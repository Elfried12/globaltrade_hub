import { IsEmail, IsNotEmpty, MinLength, IsOptional, IsIn ,IsString,
  IsDateString,IsBoolean,IsEnum,
  IsDate} from 'class-validator';
  import { Role } from '@prisma/client';

export class CreateUserDto {
  @IsNotEmpty() @IsString()    name: string;
  @IsEmail()                   email: string;
  @IsNotEmpty() @IsString()    password: string;
  @IsDateString()              date_naissance: string;    // ← string here
  @IsNotEmpty() @IsString()    sexe: 'M' | 'F';
  @IsNotEmpty() @IsString()    telephone: string;
  @IsNotEmpty() @IsString()    adresse: string;
  @IsNotEmpty() @IsString()    piece_identite: string;
  @IsOptional() @IsEnum(Role)  role?: Role;
}
