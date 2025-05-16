import { Injectable, UnauthorizedException } from '@nestjs/common';
import { PrismaService } from './prisma.service';
import { PrismaClient } from '@prisma/client';
import * as bcrypt from 'bcryptjs';
import { JwtService } from '@nestjs/jwt';
import { MailerService } from '@nestjs-modules/mailer';
import { RegisterDto } from './dto/register.dto';
import { Role }                                   from '@prisma/client';
import { LoginDto } from './dto/login.dto';

@Injectable()
export class AppService {
  usersService: any;
  constructor(private prisma: PrismaService, private jwtService: JwtService,private readonly mailer: MailerService,) {}


 async register(data: RegisterDto) {
    const hash = await bcrypt.hash(data.password, 10);

    const user = await this.usersService.create({
      name: data.name,
      email: data.email,
      password: hash,
      sexe: data.sexe,
      date_naissance: new Date(data.date_naissance),
      telephone: data.telephone,
      adresse: data.adresse,
      piece_identite: data.piece_identite,
      role: data.role ?? Role.BUYER,         // 📌 on fournit toujours un Role
    });

    await this.mailer.sendMail({
      to: user.email,
      subject: 'Bienvenue sur GlobalTrade Hub !',
      text: `
      Bonjour ${user.name},

      Merci de vous être inscrit·e sur GlobalTrade Hub.
      Votre compte est en attente de validation par l’administrateur.

      À très vite sur la plateforme !
      L’équipe GTH
            `.trim(),
          });
     return { message: 'Inscription réussie, un e-mail vient de vous être envoyé.', user: { id: user.id, email: user.email, role: user.role } };
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
