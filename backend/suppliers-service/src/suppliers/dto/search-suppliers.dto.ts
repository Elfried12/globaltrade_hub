import { IsOptional, IsString, IsBoolean } from 'class-validator';
import { Type } from 'class-transformer';

export class SearchSuppliersDto {
  @IsOptional() @IsString()           name?: string;
  @IsOptional() @IsString()           location?: string;
  @IsOptional() @Type(() => Boolean) @IsBoolean() verified?: boolean;
  @IsOptional() @Type(() => Boolean) @IsBoolean() premium?: boolean;
  /** Filtrer les fournisseurs qui ont au moins un produit dans cette catégorie */
  @IsOptional() @IsString()           category?: string;
}
