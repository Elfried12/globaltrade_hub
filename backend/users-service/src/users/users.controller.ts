import {
  Controller,
  UseGuards,
  UseInterceptors,
  UploadedFiles,
  Req,
  BadRequestException,
  Post,
  Param,
  Body,
  Delete,
  Patch,
  Get,
} from '@nestjs/common';
import { FileFieldsInterceptor } from '@nestjs/platform-express';
import { Request } from 'express';
import { JwtAuthGuard } from '../auth/jwt-auth.guard'; // adaptez le chemin si besoin
import { UsersService } from './users.service';
import { CreateProfileDto } from '../dto/create-profile.dto';
import { UpdateProfileDto } from '../dto/update-profile.dto';


@Controller('profiles')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  // … vos autres routes CRUD …

  
  @Post()
  create(@Body() dto: CreateProfileDto) {
    return this.usersService.create(dto);
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.usersService.findOne(id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() dto: UpdateProfileDto) {
    return this.usersService.update(id, dto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.usersService.remove(id);
  }

  /**
   * POST /profiles/upload-docs
   * champs multipart/form-data :
   *  - identityDocument (max 1 fichier)
   *  - residenceProof   (max 1 fichier)
   */
  @UseGuards(JwtAuthGuard)
  @Post('upload-docs')
  @UseInterceptors(
    FileFieldsInterceptor(
      [
        { name: 'identityDocument', maxCount: 1 },
        { name: 'residenceProof', maxCount: 1 },
      ],
      { limits: { fileSize: 5 * 1024 * 1024 } } // par ex. 5 Mo max
    )
  )
  async uploadDocuments(
    @UploadedFiles()
    files: {
      identityDocument?: Express.Multer.File[];
      residenceProof?: Express.Multer.File[];
    },
    @Req() req: Request
  ) {
    const userId = (req.user as any).userId; // selon votre payload JWT
    const idFile = files.identityDocument?.[0];
    const resFile = files.residenceProof?.[0];

    if (!idFile || !resFile) {
      throw new BadRequestException(
        'Vous devez fournir les deux fichiers identityDocument et residenceProof'
      );
    }

    // on passe au service le chemin relatif vers uploads/
    return this.usersService.submitDocuments(
      userId,
      idFile.filename,
      resFile.filename
    );
  }
}


