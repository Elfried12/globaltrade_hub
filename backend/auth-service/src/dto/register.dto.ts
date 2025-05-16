// src/auth/dto/register.dto.ts
import {
  IsString,
  IsNotEmpty,
  IsEmail,
  IsDateString,
  IsOptional,
  IsEnum,
  IsDate,
} from 'class-validator';
import { Role } from '@prisma/client';

export class RegisterDto {
  @IsNotEmpty() @IsString() name: string;

  @IsEmail() email: string;

  @IsNotEmpty() @IsString() password: string;

  @IsNotEmpty() @IsString()
  @IsEnum(['M', 'F'] as const)
  sexe: 'M' | 'F';

  @IsDateString()   date_naissance: string;

  @IsNotEmpty() @IsString() telephone: string;

  @IsNotEmpty() @IsString() adresse: string;

  @IsNotEmpty() @IsString() piece_identite: string;

  @IsOptional()
  @IsEnum(Role)
  role?: Role;
}
