import { IsIn } from 'class-validator';
import { ContactRequestStatus } from '@prisma/client';

export class UpdateContactRequestDto {
  @IsIn(Object.values(ContactRequestStatus))
  status: ContactRequestStatus;
}