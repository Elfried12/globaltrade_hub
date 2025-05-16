import { IsEmail, IsOptional, MinLength, IsIn,IsDateString, IsString,IsBoolean,IsNotEmpty ,IsEnum, IsDate} from 'class-validator';
import { Role } from '@prisma/client';
export class UpdateUserDto {
  @IsOptional()
  @IsString()
  name?: string;

  @IsOptional()
  @IsEmail()
  email?: string;

  @IsOptional()
  @IsString()
  password?: string;

  @IsOptional()
  @IsDate()
  date_naissance?: Date;

  @IsNotEmpty()
  @IsString()
  sexe: string;

  @IsOptional()
  @IsString()
  telephone?: string;

  @IsOptional()
  @IsString()
  address?: string;

  @IsOptional()
  @IsString()
  piece_identite?: string;

  
    @IsOptional()
    @IsBoolean()
    isVerified?: boolean;

  


   @IsOptional()
  @IsEnum(Role)
  role?: Role;
}
