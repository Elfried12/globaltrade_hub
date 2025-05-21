import { Module } from '@nestjs/common';
import { ContactsService } from './contacts.service';
import { ContactsController } from './contacts.controller';
import { PrismaModule } from 'prisma/prisma.module';
import { PrismaClient } from '@prisma/client';
import { AuthModule } from '../auth/auth.module';

@Module({
  imports: [PrismaModule,AuthModule],
  controllers: [ContactsController],
  providers: [
    ContactsService,
    {
      provide: PrismaClient,
      useValue: new PrismaClient(),
    },
  ],
})
export class ContactsModule {}
