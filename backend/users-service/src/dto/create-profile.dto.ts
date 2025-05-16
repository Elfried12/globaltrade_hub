import { IsUUID, IsNotEmpty, IsString } from 'class-validator';

export class CreateProfileDto {
  @IsUUID()
  @IsNotEmpty()
  userId: string;

  @IsString()
  @IsNotEmpty()
  name: string;

  @IsString()
  @IsNotEmpty()
  telephone: string;

  @IsString()
  @IsNotEmpty()
  address: string;

  @IsString()
  @IsNotEmpty()
  identityDocument: string;

  @IsString()
  @IsNotEmpty()
  residenceProof: string;
}
