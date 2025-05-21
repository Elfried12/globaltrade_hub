import { IsUUID } from 'class-validator';

export class CreateConversationDto {
  @IsUUID()
  buyerId: string;

  @IsUUID()
  supplierId: string;
}
