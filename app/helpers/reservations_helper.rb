module ReservationsHelper
  def self.isBookAvailable(book_id)
    reservations = Reservation.where(:book_id => book_id.to_s)
    return true if reservations.count == 0
    return reservations.all? { |r| r.return_date != nil }
  end

  def self.isBookReserved(book_id, user_id)
    reservations = Reservation.
    where(:book_id => book_id.to_s).
    and(:return_date => nil)
    if user_id
      reservations = Reservation.
      where(:book_id => book_id.to_s).
      and(:return_date => nil).
      and(:user_id => user_id.to_s)
    end
    return reservations.first if reservations.count > 0
  end

  def self.getReservedBooks(user_id)
    reservations = Reservation.
    where(:user_id => user_id.to_s).
    and(:return_date => nil)
    return reservations.map { |r| Book.find(r.book_id) }
  end

  def self.deleteBook(book_id)
    Reservation.delete_all(:book_id => book_id)
  end

  def self.deleteUser(user_id)
    Reservation.delete_all(:user_id => user_id)
  end
end
