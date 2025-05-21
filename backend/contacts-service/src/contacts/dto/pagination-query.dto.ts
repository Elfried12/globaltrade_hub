import { IsOptional, IsPositive } from 'class-validator';
import { Type } from 'class-transformer';

export class PaginationQueryDto {
  @IsOptional()
  @Type(() => Number)
  @IsPositive()
  limit?: number = 20;

  @IsOptional()
  @Type(() => Number)
  @IsPositive()
  offset?: number = 0;
}
