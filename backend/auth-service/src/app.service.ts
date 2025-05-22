// src/app.service.ts
import { Injectable, UnauthorizedException } from '@nestjs/common';
import { PrismaService } from './prisma.service';
import { PrismaClient } from '@prisma/client';
import * as bcrypt from 'bcryptjs';
import { JwtService } from '@nestjs/jwt';
import { RegisterDto } from './dto/register.dto';
import { Role } from '@prisma/client';
import { UsersService } from './users/users.service';

@Injectable()
export class AppService {
  constructor(
    private prisma: PrismaService,
    private jwtService: JwtService,
    private usersService: UsersService,
  ) {}

  async register(data: RegisterDto) {
    const hash = await bcrypt.hash(data.password, 10);

    const user = await this.usersService.create({
      name: data.name,
      email: data.email,
      password: hash,
      sexe: data.sexe,
      date_naissance: data.date_naissance,
      telephone: data.telephone,
      adresse: data.adresse,
      piece_identite: data.piece_identite,
      role: data.role ?? Role.BUYER,
    });

    return {
      message: 'Inscription réussie.',
      user: { id: user.id, email: user.email, role: user.role },
    };
  }

  async login(body: { email: string; password: string }) {
    const user = await this.prisma.user.findUnique({
      where: { email: body.email },
    });

    if (!user) {
      throw new UnauthorizedException('Email ou mot de passe incorrect');
    }

    const isPasswordValid = await bcrypt.compare(body.password, user.password);
    if (!isPasswordValid) {
      throw new UnauthorizedException('Email ou mot de passe incorrect');
    }

    const access_token = await this.jwtService.signAsync({ sub: user.id });

    return {
      access_token,
      user: {
        id: user.id,
        name: user.name,
        email: user.email,
        role: user.role,
      },
    };
  }
}