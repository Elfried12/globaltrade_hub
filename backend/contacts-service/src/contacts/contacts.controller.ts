// src/contacts.controller.ts
import {
  Controller,
  Post,
  Get,
  Patch,
  Param,
  Body,
  UseGuards,
  Req,
} from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { ContactsService } from './contacts.service';
import { CreateContactRequestDto } from './dto/create-contact-request.dto';
import { CreateMessageDto } from './dto/create-message.dto';
import { UpdateContactRequestDto } from './dto/update-contact-request.dto';

@Controller()
@UseGuards(AuthGuard('jwt'))
export class ContactsController {
  constructor(private readonly contacts: ContactsService) {}

  // --- Buyer endpoints ---
  @Post('contact-requests')
  createRequest(@Req() req, @Body() dto: CreateContactRequestDto) {
    return this.contacts.createRequest(req.user.id, dto);
  }

  @Get('contact-requests')
  listMyRequests(@Req() req) {
    return this.contacts.listMyRequests(req.user.id);
  }

  @Get('contact-requests/:id')
  getMyRequest(@Req() req, @Param('id') id: string) {
    return this.contacts.getRequest(req.user.id, id);
  }

  @Patch('contact-requests/:id/cancel')
  cancelRequest(@Req() req, @Param('id') id: string) {
    return this.contacts.cancelRequest(req.user.id, id);
  }

  // --- Supplier endpoints ---
  @Get('incoming-requests')
  listIncoming(@Req() req) {
    return this.contacts.listIncomingRequests(req.user.id);
  }

  @Patch('contact-requests/:id/accept')
  accept(@Req() req, @Param('id') id: string) {
    return this.contacts.acceptRequest(req.user.id, id);
  }

  @Patch('contact-requests/:id/refuse')
  refuse(@Req() req, @Param('id') id: string) {
    return this.contacts.refuseRequest(req.user.id, id);
  }

  // --- Conversations ---
  @Get('conversations')
  listThreads(@Req() req) {
    return this.contacts.listThreads(req.user.id);
  }

  @Get('conversations/:threadId')
  getThread(@Req() req, @Param('threadId') threadId: string) {
    return this.contacts.getThread(req.user.id, threadId);
  }

  @Get('conversations/:threadId/messages')
  listMessages(@Param('threadId') threadId: string) {
    return this.contacts.listMessages(threadId);
  }

  @Post('conversations/:threadId/messages')
  postMessage(
    @Req() req,
    @Param('threadId') threadId: string,
    @Body() dto: CreateMessageDto,
  ) {
    return this.contacts.createMessage(
      req.user.id,
      req.user.role,
      threadId,
      dto,
    );
  }
}
