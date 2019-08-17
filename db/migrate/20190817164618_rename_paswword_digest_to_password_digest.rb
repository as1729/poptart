class RenamePaswwordDigestToPasswordDigest < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :paswword_digest, :password_digest
  end
end
