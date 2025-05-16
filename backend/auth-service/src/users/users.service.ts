import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService }                 from 'prisma/prisma.service';
import { User, Role }                    from '@prisma/client';
import { CreateUserDto }                 from './dto/create-user.dto';
import { UpdateUserDto }                 from './dto/update-user.dto';

@Injectable()
export class UsersService {
  constructor(private readonly prisma: PrismaService) {}

  async create(dto: CreateUserDto): Promise<User> {
    // destructure everything Prisma expects, supply a default for `role`
    const {
      name,
      email,
      password,
      date_naissance,
      sexe,
      telephone,
      adresse,            // note the field name matches your Prisma schema
      piece_identite,
      role = Role.BUYER,  // default if none provided
    } = dto;

    return this.prisma.user.create({
      data: {
        name,
        email,
        password,
        date_naissance,
        sexe,
        telephone,
        adresse,
        piece_identite,
        role,
      },
    });
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
