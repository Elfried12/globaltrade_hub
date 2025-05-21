// src/contacts.service.ts
import { Injectable, ForbiddenException, NotFoundException } from '@nestjs/common';
import { PrismaService } from 'prisma/prisma.service';
import {ContactRequest,ContactThread,Message,ContactRequestStatus,Role,} from '@prisma/client';
import { CreateContactRequestDto } from './dto/create-contact-request.dto';
import { UpdateContactRequestDto } from './dto/update-contact-request.dto';
import { CreateMessageDto } from './dto/create-message.dto';

@Injectable()
export class ContactsService {
  constructor(private readonly prisma: PrismaService) {}

  // ----- Contact Requests -----

  async createRequest(
    buyerId: string,
    dto: CreateContactRequestDto,
  ): Promise<ContactRequest> {
    return this.prisma.contactRequest.create({
      data: {
        userId: buyerId,
        supplierId: dto.supplierId,
        productId: dto.productId,
      },
    });
  }

  async listMyRequests(buyerId: string): Promise<ContactRequest[]> {
    return this.prisma.contactRequest.findMany({
      where: { userId: buyerId },
      orderBy: { createdAt: 'desc' },
    });
  }

  async cancelRequest(buyerId: string, id: string): Promise<ContactRequest> {
    const req = await this.prisma.contactRequest.findUnique({ where: { id }});
    if (!req || req.userId !== buyerId) throw new NotFoundException();
    if (req.status !== ContactRequestStatus.PENDING)
      throw new ForbiddenException(`Cannot cancel a ${req.status} request`);
    return this.prisma.contactRequest.update({
      where: { id },
      data: { status: ContactRequestStatus.CANCELLED, respondedAt: new Date() },
    });
  }

  async getRequest(buyerId: string, id: string): Promise<ContactRequest> {
    const req = await this.prisma.contactRequest.findUnique({ where: { id }});
    if (!req || req.userId !== buyerId) throw new NotFoundException();
    return req;
  }

  // Supplier side

  async listIncomingRequests(supplierId: string): Promise<ContactRequest[]> {
    return this.prisma.contactRequest.findMany({
      where: { supplierId },
      orderBy: { createdAt: 'desc' },
    });
  }

  private async _acceptOrRefuse(
    supplierId: string,
    id: string,
    status: ContactRequestStatus.ACCEPTED | ContactRequestStatus.REFUSED,
  ): Promise<ContactRequest> {
    const req = await this.prisma.contactRequest.findUnique({ where: { id }});
    if (!req || req.supplierId !== supplierId) throw new NotFoundException();
    if (req.status !== ContactRequestStatus.PENDING)
      throw new ForbiddenException(`Cannot ${status.toLowerCase()} a ${req.status} request`);

    // update request
    const updated = await this.prisma.contactRequest.update({
      where: { id },
      data: { status, respondedAt: new Date() },
    });

    if (status === ContactRequestStatus.ACCEPTED) {
      // créer un thread de discussion
      await this.prisma.contactThread.create({
        data: {
          userId: req.userId,
          supplierId,
        },
      });
    }

    return updated;
  }

  async acceptRequest(supplierId: string, id: string) {
    return this._acceptOrRefuse(supplierId, id, ContactRequestStatus.ACCEPTED);
  }

  async refuseRequest(supplierId: string, id: string) {
    return this._acceptOrRefuse(supplierId, id, ContactRequestStatus.REFUSED);
  }

  // ----- Conversations & Messages -----

  async listThreads(userId: string): Promise<ContactThread[]> {
    return this.prisma.contactThread.findMany({
      where: { OR: [{ userId }, { supplierId: userId }] },
      orderBy: { updatedAt: 'desc' },
    });
  }

  async getThread(userId: string, threadId: string): Promise<ContactThread> {
    const thread = await this.prisma.contactThread.findUnique({
      where: { id: threadId },
    });
    if (!thread || (thread.userId !== userId && thread.supplierId !== userId))
      throw new NotFoundException();
    return thread;
  }

  async listMessages(threadId: string): Promise<Message[]> {
    return this.prisma.message.findMany({
      where: { threadId },
      orderBy: { sentAt: 'asc' },
    });
  }

  async createMessage(
    senderId: string,
    senderRole: Role,
    threadId: string,
    dto: CreateMessageDto,
  ): Promise<Message> {
    const thread = await this.getThread(senderId, threadId);
    // role guard :
    if (
      (senderRole === Role.BUYER && thread.userId !== senderId) ||
      (senderRole === Role.SUPPLIER && thread.supplierId !== senderId)
    ) {
      throw new ForbiddenException(`You cannot post to this thread`);
    }
    // créer
    return this.prisma.message.create({
      data: {
        threadId,
        senderId,
        senderRole,
        content: dto.content,
        attachmentUrl: dto.attachmentUrl,
      },
    });
  }
}
