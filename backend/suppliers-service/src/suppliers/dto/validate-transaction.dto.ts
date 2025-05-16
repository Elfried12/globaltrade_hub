import { IsNotEmpty, IsString } from 'class-validator';

export class ValidateTransactionDto {
  @IsString()
  @IsNotEmpty()
  confirmationDetails: string;
}
