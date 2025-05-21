import { ApiProperty } from '@nestjs/swagger';
import { MessageEntity } from './message.entity';

export class ConversationEntity {
  @ApiProperty({ description: 'UUID de la conversation' })
  id: string;

  @ApiProperty({ description: 'UUID de l’acheteur (buyer)' })
  buyerId: string;

  @ApiProperty({ description: 'UUID du fournisseur (supplier)' })
  supplierId: string;

  @ApiProperty({ description: 'Date de création de la conversation' })
  createdAt: Date;

  @ApiProperty({ description: 'Date de dernière mise à jour' })
  updatedAt: Date;

  @ApiProperty({
    type: () => [MessageEntity],
    description: 'Liste des messages rattachés à cette conversation',
    required: false,
  })
  messages?: MessageEntity[];
}
