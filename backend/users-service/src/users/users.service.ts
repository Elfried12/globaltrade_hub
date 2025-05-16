import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from 'prisma/prisma.service';
import { CreateProfileDto } from '../dto/create-profile.dto';
import { UpdateProfileDto } from '../dto/update-profile.dto';


@Injectable()
export class UsersService {
  constructor(private readonly prisma: PrismaService) {}
  
   async create(dto: CreateProfileDto) {
    return this.prisma.profile.create({ data: dto });
  }

  async findAll() {
    return this.prisma.profile.findMany();
  }

  async findOne(id: string) {
    const profile = await this.prisma.profile.findUnique({ where: { id } });
    if (!profile) throw new NotFoundException(`Profile with id "${id}" not found`);
    return profile;
  }

  async update(id: string, dto: UpdateProfileDto) {
    await this.findOne(id);
    return this.prisma.profile.update({ where: { id }, data: dto });
  }

  async remove(id: string) {
    await this.findOne(id);
    return this.prisma.profile.delete({ where: { id } });
  }


  // … vos méthodes existantes …
  

  /**
   * Met à jour les champs identityDocument & residenceProof
   * du Profile lié à l'userId
   */
  async submitDocuments(
    userId: string,
    identityDocumentFilename: string,
    residenceProofFilename: string
  ) {
    // on récupère d’abord le profil
    const profile = await this.prisma.profile.findUnique({
      where: { userId },
    });
    if (!profile) {
      throw new NotFoundException('Profil introuvable pour cet utilisateur');
    }
    return this.prisma.profile.update({
      where: { userId },
      data: {
        identityDocument: identityDocumentFilename,
        residenceProof: residenceProofFilename,
        // on reste isValidated à false: l'admin validera après
      },
    });
  }
}
