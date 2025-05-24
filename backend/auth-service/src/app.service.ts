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
  if (!body.email || !body.password) {
    throw new UnauthorizedException('Email et mot de passe sont requis');
  }

  console.log('Recherche de l\'utilisateur avec email :', body.email);
  const user = await this.prisma.user.findUnique({
    where: { email: body.email },
  });

  if (!user) {
    console.log('Utilisateur non trouvé pour email :', body.email);
    throw new UnauthorizedException('Email ou mot de passe incorrect');
  }

  console.log('Mot de passe haché dans la base :', user.password);
  console.log('Mot de passe fourni :', body.password);
  const isPasswordValid = await bcrypt.compare(body.password, user.password);
  if (!isPasswordValid) {
    console.log('Mot de passe invalide pour email :', body.email);
    throw new UnauthorizedException('Email ou mot de passe incorrect');
  }

  console.log('Connexion réussie pour utilisateur :', user.email);
  const access_token = await this.jwtService.signAsync({ sub: user.id });

  return {
    accessToken: access_token,
    user: {
      id: user.id,
      email: user.email,
      role: user.role,
    },
  };
}
}