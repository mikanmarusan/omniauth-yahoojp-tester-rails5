class SessionsController < ApplicationController
        def top
                render 'sessions/top'
        end

        def callback
                auth = request.env['omniauth.auth']

                @uid = auth.uid
                @extra = auth.extra
                
                @sub = auth.info.sub
                @name = auth.info.name
                @given_name = auth.info.given_name
                @given_name_ja_kana_jp = auth.info.given_name_ja_kana_jp
                @given_name_ja_hani_jp = auth.info.given_name_ja_hani_jp
                @family_name = auth.info.family_name
                @family_name_ja_kana_jp = auth.info.family_name_ja_kana_jp
                @family_name_ja_hani_jp = auth.info.family_name_ja_hani_jp
                @gender = auth.info.gender
                @zoneinfo = auth.info.zoneinfo
                @locale = auth.info.locale
                @birthdate = auth.info.birthdate
                @nickname = auth.info.nickname
                @picture = auth.info.picture
                @email = auth.info.email
                @email_verified = auth.info.email_verified
                @address = {
                    'country' => auth.info.address['country'],
                    'postal_code' => auth.info.address['postal_code'],
                    'region' => auth.info.address['region'],
                    'locality' => auth.info.address['locality'],
                    'formatted' => auth.info.address['formatted']
                }

                @token         = auth.credentials.token;
                @refresh_token = auth.credentials.refresh_token;
                @expires_at    = auth.credentials.expires_at;

                render 'sessions/callback'
        end
end
