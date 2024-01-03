module my_addrx::table{

   use aptos_std::table::{Self, Table};
   use std::string;
   use std::signer;
   use std::debug::print;




    struct StoreUserDetails has key{ 
        list_of_users : Table<string::String , u8>
    }

    struct OwnerDetails has drop , copy{
        name:string::String
    }

    struct Owner has key{
        owner:Table< OwnerDetails, u8>
    }

    // fun init_module(account:&signer) {
        
        
    // }

   public entry fun initialize_module(account:&signer) {

      assert!(!exists<Owner>(@my_addrx),22233);
       
       move_to(account ,StoreUserDetails{
        list_of_users:table::new<string::String , u8>()
       });
       move_to(account ,Owner{
            owner:table::new< OwnerDetails , u8>()
        })
   }


   public entry fun store_values_in_table(account:&signer) acquires StoreUserDetails ,Owner {
     let user_addr = signer::address_of(account);
     assert!(exists<StoreUserDetails>(user_addr),33333);

     let list_of_users : &mut Table<string::String , u8>  = &mut borrow_global_mut<StoreUserDetails>(user_addr).list_of_users;
     let owner : &mut Table<OwnerDetails , u8>   = &mut borrow_global_mut<Owner>(user_addr).owner;

     table::add(list_of_users , string::utf8(b"Bhushan"),2);
     table::add(owner ,OwnerDetails{name:string::utf8(b"Hemanth")}, 1 );
     table::add(list_of_users , string::utf8(b"Akhi"),0);
     table::add(owner ,OwnerDetails{name:string::utf8(b"Random")}, 3 );
     table::add(list_of_users , string::utf8(b"Check"),9);
     table::add(owner ,OwnerDetails{name:string::utf8(b"Done")}, 2 );
      let list_of_users : &Table<string::String , u8>  = &borrow_global<StoreUserDetails>(user_addr).list_of_users;
     print(&string::utf8(b"Heman---------------------------------------------------------th"));
    //  let list_of_users1 : &Table<string::String , u8>  = &mut borrow_global<StoreUserDetails>(user_addr).list_of_users;
     print(&table::contains(list_of_users,string::utf8(b"Random")));
     print(&table::contains(owner,OwnerDetails{name:string::utf8(b"Random")}));
     print(owner)
     
   }

    #[test(account = @my_addrx)]

    public fun test_check(account:&signer) acquires Owner , StoreUserDetails{
        initialize_module(account);
      store_values_in_table(account)


    }
    }