import { IsIn, IsNotEmpty, IsString } from 'class-validator';

export class CreateResponseDto {
  @IsIn(['ACCEPTED', 'REFUSED'])
  status: 'ACCEPTED' | 'REFUSED';

  @IsString()
  @IsNotEmpty()
  message: string;
}
