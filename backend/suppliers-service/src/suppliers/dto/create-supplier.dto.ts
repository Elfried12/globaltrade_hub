export class CreateSupplierDto {
  name: string;
  email: string;
  telephone: string;
  companyName: string;
  companyNumber: string;
  legalDocs: string;
  premium: boolean;
  address: string;
  isVerified?: boolean;
}