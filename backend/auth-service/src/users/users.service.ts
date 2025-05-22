// src/users/users.service.ts
import { Injectable, NotFoundException, ConflictException } from '@nestjs/common';
import { PrismaService } from 'prisma/prisma.service';
import { User, Role } from '@prisma/client';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';

@Injectable()
export class UsersService {
  constructor(private readonly prisma: PrismaService) {}

  async create(dto: CreateUserDto): Promise<User> {
    const {
      name,
      email,
      password,
      date_naissance,
      sexe,
      telephone,
      adresse,
      piece_identite,
      role = Role.BUYER,
    } = dto;

    try {
      return await this.prisma.user.create({
        data: {
          name,
          email,
          password,
          date_naissance: new Date(date_naissance),
          sexe,
          telephone,
          adresse,
          piece_identite,
          role,
        },
      });
    } catch (error) {
      if (error.code === 'P2002') { // Code Prisma pour violation de contrainte unique
        throw new ConflictException('Cet e-mail est déjà utilisé.');
      }
      throw error; // Relancer d'autres erreurs pour débogage
    }
  }

  async findAll(): Promise<User[]> {
    return this.prisma.user.findMany();
  }

  async findOne(id: string): Promise<User> {
    const user = await this.prisma.user.findUnique({ where: { id } });
    if (!user) throw new NotFoundException(`User ${id} not found`);
    return user;
  }

  async update(id: string, data: UpdateUserDto): Promise<User> {
    await this.findOne(id);
    return this.prisma.user.update({ where: { id }, data });
  }

  async remove(id: string): Promise<User> {
    await this.findOne(id);
    return this.prisma.user.delete({ where: { id } });
  }

  async verifyUser(id: string): Promise<User> {
    return this.prisma.user.update({
      where: { id },
      data: { isVerified: true },
    });
  }

  async findByEmail(email: string): Promise<User | null> {
    return this.prisma.user.findUnique({ where: { email } });
  }
}