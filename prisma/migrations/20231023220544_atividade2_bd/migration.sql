-- CreateTable
CREATE TABLE `Categoria` (
    `categoria_id` INTEGER NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(255) NOT NULL,

    PRIMARY KEY (`categoria_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `SubCategoria` (
    `subcategoria_id` INTEGER NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(255) NOT NULL,
    `categoriaid` INTEGER NOT NULL,

    PRIMARY KEY (`subcategoria_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Cliente` (
    `cliente_id` INTEGER NOT NULL AUTO_INCREMENT,
    `nome_completo` VARCHAR(255) NOT NULL,
    `cpf` VARCHAR(14) NOT NULL,
    `numero_celular` VARCHAR(15) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `data_nascimento` DATETIME(3) NOT NULL,

    UNIQUE INDEX `Cliente_cpf_key`(`cpf`),
    UNIQUE INDEX `Cliente_numero_celular_key`(`numero_celular`),
    UNIQUE INDEX `Cliente_email_key`(`email`),
    PRIMARY KEY (`cliente_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Endereco` (
    `endereco_id` INTEGER NOT NULL AUTO_INCREMENT,
    `rua` VARCHAR(255) NOT NULL,
    `cidade` VARCHAR(255) NOT NULL,
    `estado` VARCHAR(255) NOT NULL,
    `cep` VARCHAR(11) NOT NULL,
    `clienteid` INTEGER NOT NULL,

    PRIMARY KEY (`endereco_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Compra` (
    `compra_id` INTEGER NOT NULL AUTO_INCREMENT,
    `data_hora` DATETIME(3) NOT NULL,
    `desconto` DECIMAL(9, 2) NOT NULL,
    `forma_pagamento` VARCHAR(255) NOT NULL,
    `total_compra` DECIMAL(9, 2) NOT NULL,
    `clienteid` INTEGER NOT NULL,
    `enderecoid` INTEGER NOT NULL,

    PRIMARY KEY (`compra_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Modelo` (
    `modelo_id` INTEGER NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(255) NOT NULL,

    PRIMARY KEY (`modelo_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `NumeroSerie` (
    `numero_serie_id` INTEGER NOT NULL AUTO_INCREMENT,
    `numero_serie` VARCHAR(255) NOT NULL,
    `modelo_id` INTEGER NOT NULL,

    PRIMARY KEY (`numero_serie_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `produto` (
    `produto_id` INTEGER NOT NULL AUTO_INCREMENT,
    `preco_base` DECIMAL(9, 2) NOT NULL,
    `quantidade` INTEGER NOT NULL,
    `categoriaid` INTEGER NOT NULL,
    `modeloid` INTEGER NOT NULL,

    PRIMARY KEY (`produto_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `CompraProduto` (
    `compra_id` INTEGER NOT NULL AUTO_INCREMENT,
    `compraid` INTEGER NOT NULL,
    `produtoid` INTEGER NOT NULL,

    PRIMARY KEY (`compra_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `SubCategoria` ADD CONSTRAINT `SubCategoria_categoriaid_fkey` FOREIGN KEY (`categoriaid`) REFERENCES `Categoria`(`categoria_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Endereco` ADD CONSTRAINT `Endereco_clienteid_fkey` FOREIGN KEY (`clienteid`) REFERENCES `Cliente`(`cliente_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Compra` ADD CONSTRAINT `Compra_clienteid_fkey` FOREIGN KEY (`clienteid`) REFERENCES `Cliente`(`cliente_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Compra` ADD CONSTRAINT `Compra_enderecoid_fkey` FOREIGN KEY (`enderecoid`) REFERENCES `Endereco`(`endereco_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `NumeroSerie` ADD CONSTRAINT `NumeroSerie_modelo_id_fkey` FOREIGN KEY (`modelo_id`) REFERENCES `Modelo`(`modelo_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `produto` ADD CONSTRAINT `produto_categoriaid_fkey` FOREIGN KEY (`categoriaid`) REFERENCES `Categoria`(`categoria_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `produto` ADD CONSTRAINT `produto_modeloid_fkey` FOREIGN KEY (`modeloid`) REFERENCES `Modelo`(`modelo_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `CompraProduto` ADD CONSTRAINT `CompraProduto_compraid_fkey` FOREIGN KEY (`compraid`) REFERENCES `Compra`(`compra_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `CompraProduto` ADD CONSTRAINT `CompraProduto_produtoid_fkey` FOREIGN KEY (`produtoid`) REFERENCES `produto`(`produto_id`) ON DELETE RESTRICT ON UPDATE CASCADE;
