grant select (
 id, market_region, country_code, listing_intent, property_category, property_subtype,
 title, description, city, state_region, postal_code, neighborhood, community, building_name,
 latitude, longitude, price, currency, rental_period, bedrooms, bathrooms, area, area_unit,
 lot_area, parking_spaces, year_built, floor_number, total_floors, furnished_status,
 availability_date, lease_term_months, amenities, photo_urls, listing_source, brokerage_name,
 agent_license_authority, public_contact_name, public_contact_phone, public_contact_email,
 property_stage, tenure_type, property_condition, service_charge, service_charge_period,
 verification_status, created_at, updated_at
) on public.property_listings to anon;
