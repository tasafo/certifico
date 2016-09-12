class PagseguroCodes
  TRANSACTION_STATUS = {
    '1' => 'Aguardando pagamento',
    '2' => 'Em análise',
    '3' => 'Paga',
    '4' => 'Disponível',
    '5' => 'Em disputa',
    '6' => 'Devolvida',
    '7' => 'Cancelada',
    '8' => 'Debitado',
    '9' => 'Retenção temporária'
  }

  PAYMENT_METHOD = {
    '1' => 'Cartão de crédito',
    '2' => 'Boleto',
    '3' => 'Débito online (TEF)',
    '4' => 'Saldo PagSeguro',
    '5' => 'Oi Paggo',
    '7' => 'Depósito em conta'
  }

  def self.status(code)
    TRANSACTION_STATUS[code]
  end

  def self.method(code)
    PAYMENT_METHOD[code]
  end
end
