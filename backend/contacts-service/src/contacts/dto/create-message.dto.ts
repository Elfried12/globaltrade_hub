import { IsUUID, IsEnum, IsString,IsOptional } from 'class-validator';
import { Role } from '@prisma/client';

export class CreateMessageDto {
  @IsUUID()
  conversationId: string;

  @IsEnum(Role)
  sender: Role; // BUYER | SUPPLIER

  @IsString()
  content: string;

  
  @IsString()
  @IsOptional()
  attachmentUrl?: string;
}
