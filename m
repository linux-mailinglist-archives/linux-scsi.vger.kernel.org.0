Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0257940C3BE
	for <lists+linux-scsi@lfdr.de>; Wed, 15 Sep 2021 12:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhIOKoo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 15 Sep 2021 06:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbhIOKom (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 15 Sep 2021 06:44:42 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AEDC061574
        for <linux-scsi@vger.kernel.org>; Wed, 15 Sep 2021 03:43:23 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id i23so2264137vsj.4
        for <linux-scsi@vger.kernel.org>; Wed, 15 Sep 2021 03:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=jugmU6zxXuRvTadmLkTuUJDMJv4tKYHJ4uha6ABX0aY=;
        b=RQfVbzQbUkJnwgl3izV3RUvFq3AWVYMHUe62cksRkS4MrIKEZ9T3+/UwO+elTE9G04
         z3i96IzSZZANESxSeeSXIRCqLzQNTzQZW2tEStv/Y85C6Ewwk66mNhtLbEdRQYNV7gwD
         5m8wo37kWreqHr8RoMhHiJkF2JD3XsdOjgTac7KTC4LhNtmwaLDd+kap9soPJxn+ad4M
         dNE3Ul74FG5h++/olaxSH9aUoOBc+cuYRlPKKl3vO/tESEX4KUyQcvpx7jY/IS6KcYtj
         fkj359gTSwmEvGMzxmhOqt2Du1J8ANd53ryBz2wRLBAgESgUXkpWVKu+7XyuwsZZHsrS
         Z0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=jugmU6zxXuRvTadmLkTuUJDMJv4tKYHJ4uha6ABX0aY=;
        b=HP4ngwPQnOO2s7TsWAcvC+3Y8fnDS/fRkCHrSJUCL34l0pqrqEbweVa+SngxVh2ObF
         uS4H0PGS14kMAoB5AgNJzoXF81LBuORPKeUg/FAj5ZmTWyERfv8ppKuRWubj9IzbiMgN
         S8EwhWwEO2dXDZLCQFTWdd1RnpySrIXj+gEjIuU1Lcm4T8w4LkdvQDIaJa8rCcgZ02vO
         8SJka1h2RVmcE8rJkP4ZoW5GPZue+0KAUj55VO20R5vr/hS76+JOdpcUQjcgSVVVd0t5
         gfpwA5o/sK0x77d+1llEMdaJwHG6zdAIVkY+Dga7hd82b16DYZvwTuLS+l9JIGu2mupY
         bMEw==
X-Gm-Message-State: AOAM531GXWr/n+WJqplUbnHcCOoqmjmW0lE3VeqfcAVCqeMB3Xt8htfp
        kIjrE8r5F3AWo76yshoeMDxCn4YYO/lYtVyPXVM=
X-Google-Smtp-Source: ABdhPJw2vgjTsz6QN10gcp0SPQxb/lgwIMCQjybPvC0plJ0nx+3pTDd2I+QUOxzlsshy8KlslJK8Q5znSSjYdHbFfOU=
X-Received: by 2002:a05:6102:d8:: with SMTP id u24mr2676521vsp.48.1631702602696;
 Wed, 15 Sep 2021 03:43:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2785:0:0:0:0:0 with HTTP; Wed, 15 Sep 2021 03:43:21
 -0700 (PDT)
Reply-To: liampayen50@gmail.com
From:   liam payen <io452404@gmail.com>
Date:   Wed, 15 Sep 2021 03:43:21 -0700
Message-ID: <CAA+kqzz0uf3yV1jspM89eWUzpcSXXahkm9sU0ySV9T0ZmvLDhQ@mail.gmail.com>
Subject: =?UTF-8?B?5oiR6ZyA6KaB5L2g55qE5biu5Yqp?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

5oiR5piv5Yip5Lqa5aeGwrfkvanmgankuK3lo6vlpKvkurrjgIINCg0K5Zyo576O5Zu96ZmG5Yab
55qE5Yab5LqL6YOo6Zeo44CC576O5Zu977yM5LiA5ZCN5Lit5aOr77yMMzIg5bKB77yM5oiR5Y2V
6Lqr77yM5p2l6Ieq576O5Zu955Sw57qz6KW/5bee5YWL5Yip5aSr5YWw77yM55uu5YmN6am75omO
5Zyo5Yip5q+U5Lqa54+t5Yqg6KW/77yM5LiO5oGQ5oCW5Li75LmJ5L2c5oiY44CC5oiR55qE5Y2V
5L2N5piv56ysNOaKpOeQhumYn+esrDc4MuaXheaUr+aPtOiQpeOAgg0KDQrmiJHmmK/kuIDkuKrl
hYXmu6HniLHlv4PjgIHor5rlrp7lkozmt7Hmg4XnmoTkurrvvIzlhbfmnInoia/lpb3nmoTlub3p
u5jmhJ/vvIzmiJHllpzmrKLnu5Por4bmlrDmnIvlj4vlubbkuobop6Pku5bku6znmoTnlJ/mtLvm
lrnlvI/vvIzmiJHllpzmrKLnnIvliLDlpKfmtbfnmoTms6LmtarlkozlsbHohInnmoTnvo7kuL3k
u6Xlj4rlpKfoh6rnhLbmiYDmi6XmnInnmoTkuIDliIfmj5DkvpvjgILlvojpq5jlhbTog73mm7Tl
pJrlnLDkuobop6PmgqjvvIzmiJHorqTkuLrmiJHku6zlj6/ku6Xlu7rnq4voia/lpb3nmoTllYbk
uJrlj4vosIrjgIINCg0K5oiR5LiA55u05b6I5LiN5byA5b+D77yM5Zug5Li66L+Z5Lqb5bm05p2l
55Sf5rS75a+55oiR5LiN5YWs5bmz77yb5oiR5aSx5Y675LqG54i25q+N77yM6YKj5bm05oiRIDIx
DQrlsoHjgILmiJHniLbkurLnmoTlkI3lrZfmmK/luJXnibnph4zmlq/kvanmganvvIzmiJHnmoTm
r43kurLmmK/njpvkuL3kvanmganjgILmsqHmnInkurrluK7liqnmiJHvvIzkvYblvojpq5jlhbTm
iJHnu4jkuo7lnKjnvo7lhpvkuK3mib7liLDkuoboh6rlt7HjgIINCg0K5oiR57uT5ama55Sf5LqG
5a2p5a2Q77yM5L2G5LuW5q275LqG77yM5LiN5LmF5oiR5LiI5aSr5byA5aeL5qy66aqX5oiR77yM
5omA5Lul5oiR5LiN5b6X5LiN5pS+5byD5ama5ae744CCDQoNCuaIkeS5n+W+iOW5uOi/kO+8jOWc
qOaIkeeahOWbveWutue+juWbveWSjOWIqeavlOS6muePreWKoOilv+i/memHjOaLpeacieaIkeeU
n+a0u+S4reaJgOmcgOeahOS4gOWIh++8jOS9huayoeacieS6uuS4uuaIkeaPkOS+m+W7uuiuruOA
guaIkemcgOimgeS4gOS4quivmuWunueahOS6uuadpeS/oeS7u++8jOS7luS5n+S8muWwseWmguS9
leaKlei1hOaIkeeahOmSseaPkOS+m+W7uuiuruOAguWboOS4uuaIkeaYr+aIkeeItuavjeWcqOS7
luS7rOWOu+S4luWJjeeUn+S4i+eahOWUr+S4gOS4gOS4quWls+WtqeOAgg0KDQrmiJHkuI3orqTo
r4bkvaDmnKzkurrvvIzkvYbmiJHorqTkuLrmnInkuIDkuKrlgLzlvpfkv6HotZbnmoTlpb3kurrv
vIzku5blj6/ku6Xlu7rnq4vnnJ/mraPnmoTkv6Hku7vlkozoia/lpb3nmoTllYbkuJrlj4vosIrv
vIzlpoLmnpzkvaDnnJ/nmoTmnInkuIDkuKror5rlrp7nmoTlkI3lrZfvvIzmiJHkuZ/mnInkuIDk
upvkuJzopb/opoHlkozkvaDliIbkuqvnm7jkv6HjgILlnKjkvaDouqvkuIrvvIzlm6DkuLrmiJHp
nIDopoHkvaDnmoTluK7liqnjgILmiJHmi6XmnInmiJHlnKjliKnmr5Tkuprnj63liqDopb/ov5np
h4zotZrliLDnmoTmgLvpop3vvIgyNTANCuS4h+e+juWFg++8ieOAguaIkeS8muWcqOS4i+S4gOWw
geeUteWtkOmCruS7tuS4reWRiuivieS9oOaIkeaYr+WmguS9leWBmuWIsOeahO+8jOS4jeimgeaD
iuaFjO+8jOS7luS7rOayoeaciemjjumZqe+8jOiAjOS4lOaIkei/mOWcqOS4jiBSZWQNCuacieiB
lOezu+eahOS6uumBk+S4u+S5ieWMu+eUn+eahOW4ruWKqeS4i+Wwhui/meeslOmSseWtmOWFpeS6
humTtuihjOOAguaIkeW4jOacm+aCqOWwhuiHquW3seS9nOS4uuaIkeeahOWPl+ebiuS6uuadpeaO
peaUtuWfuumHkeW5tuWcqOaIkeWcqOi/memHjOWujOaIkOWQjuehruS/neWug+eahOWuieWFqOW5
tuiOt+W+l+aIkeeahOWGm+S6i+mAmuihjOivgeS7peWcqOaCqOeahOWbveWutuS4juaCqOS8mumd
ou+8m+S4jeimgeWus+aAlemTtuihjOS8muWwhui1hOmHkeWtmOWCqOWcqA0KQVRNIFZJU0Eg5Y2h
5Lit77yM6L+Z5a+55oiR5Lus5p2l6K+05piv5a6J5YWo5LiU5b+r5o2355qE44CCDQoNCueslOiu
sDvmiJHkuI3nn6XpgZPmiJHku6zopoHlnKjov5nph4zlkYblpJrkuYXvvIzmiJHnmoTlkb3ov5Dv
vIzlm6DkuLrmiJHlnKjov5nph4zkuKTmrKHngrjlvLnooq3lh7vkuK3lubjlrZjkuIvmnaXvvIzo
v5nkv4Pkvb/miJHlr7vmib7kuIDkuKrlgLzlvpfkv6HotZbnmoTkurrmnaXluK7liqnmiJHmjqXm
lLblkozmipXotYTln7rph5HvvIzlm6DkuLrmiJHlsIbmnaXliLDkvaDku6znmoTlm73lrrblh7ro
uqvmipXotYTvvIzlvIDlp4vmlrDnlJ/mtLvvvIzkuI3lho3lvZPlhbXjgIINCg0K5aaC5p6c5oKo
5oS/5oSP6LCo5oWO5aSE55CG77yM6K+35Zue5aSN5oiR44CC5oiR5Lya5ZGK6K+J5L2g5LiL5LiA
5q2l55qE5rWB56iL77yM5bm257uZ5L2g5Y+R6YCB5pu05aSa5YWz5LqO5Z+66YeR5a2Y5YWl6ZO2
6KGM55qE5L+h5oGv44CC5Lul5Y+K6ZO26KGM5bCG5aaC5L2V5biu5Yqp5oiR5Lus6YCa6L+HIEFU
TSBWSVNBDQpDQVJEIOWwhui1hOmHkei9rOenu+WIsOaCqOeahOWbveWuti/lnLDljLrjgILlpoLm
npzkvaDmnInlhbTotqPvvIzor7fkuI7miJHogZTns7vjgIINCg==
