import { ApiProperty } from '@nestjs/swagger';
import { Role } from '@prisma/client';

export class MessageEntity {
  @ApiProperty({ description: 'UUID du message' })
  id: string;

  @ApiProperty({ description: 'UUID de la conversation parente' })
  conversationId: string;

  @ApiProperty({ enum: Role, description: 'Rôle de l’émetteur (BUYER ou SUPPLIER)' })
  sender: Role;

  @ApiProperty({ description: 'Contenu textuel du message' })
  content: string;

  @ApiProperty({ description: 'Date et heure d’envoi du message' })
  sentAt: Date;

  @ApiProperty({ description: 'Marqueur indiquant si le message a été lu' })
  isRead: boolean;
}
