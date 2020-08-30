Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844F2256C86
	for <lists+linux-scsi@lfdr.de>; Sun, 30 Aug 2020 09:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgH3HSv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 30 Aug 2020 03:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgH3HSu (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 30 Aug 2020 03:18:50 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA7DC061573
        for <linux-scsi@vger.kernel.org>; Sun, 30 Aug 2020 00:18:49 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id m22so3267063ljj.5
        for <linux-scsi@vger.kernel.org>; Sun, 30 Aug 2020 00:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=4q5YOR53Cj/6goT3b+N1mUGukdgJwzByS4td8aPk99M=;
        b=Px0msUqhKUXG6/3tAVNNC3g18Hd0cbWi8GoPEcwVFiMYOlLWrUx+ykt+oM4X38rzoT
         Jhcr/TdwCzPlnOh+UIh+pv+IMtJoitF3GGfTUirMszn5sIhK2MkL6x8jyYENWbqgxS4B
         wAupDD+0GltvzpNX3yPwKLSjbpLCdwmDR5uY5ZPqYIGG3MypBP5OYhg23I92GNS5JaLH
         YL1mCMHT4UGJCu5LOTEfryDamQ+pYyIF/vgeU2dh6GhViOplA7woii1EhrWZJtvI7fZl
         DZdltliwVTTNui5xnvJutZGp1lZh7u5Z2quzOom0GIGn+TfB6MSs3X6lzBsj5ohmscKW
         Sm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=4q5YOR53Cj/6goT3b+N1mUGukdgJwzByS4td8aPk99M=;
        b=Y/ZVcC8XoH687Yu8iGdQhLRQtrHz2QmyT4XuAnXptdkl3mhE5ev5rB6IcZEMUUlJAm
         XJnNl10zXWyyah6F6eEqQH32V7o7UvwYgS7X7wKICXn30LiFPJtwdyGcmZPCZd2i+W/W
         OrRp5yVD0fNaE/7ClNTLb2xLbk8pA3WMR22+pbxBodlW5+Czb1VBqPZOVAWJ+n1k9srj
         kVyx19TOXv9HszNq1H0/4C41FbX5xyjqzXE0dIi0Ts9wZmRMgAGQbHoIUzWRFvOeMlrt
         olkkOg9/R8qWpOvAl3CIx4DBRpg6RQ1C2HCjXd2Gr+mu/SJ7RXzePipxP96f0NTpyDlF
         VAKg==
X-Gm-Message-State: AOAM5302JtvSnApzmlsNrq7PDB2BHrm+9ToB38TSgtL9iUcbMww00pC+
        smprfXVjDkKHGg3tjVBaVQYyF1shx1JELq1qIgw=
X-Google-Smtp-Source: ABdhPJwLH4GffRwwh4TOgZmgFfl6v9KPVmEBDVnPHv89RC+UogzLUuwPCVrQVG+1ITTjbBHLqOr5hFtjdxtuC29bNvw=
X-Received: by 2002:a05:651c:1136:: with SMTP id e22mr2677250ljo.422.1598771928180;
 Sun, 30 Aug 2020 00:18:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:c7c1:0:0:0:0:0 with HTTP; Sun, 30 Aug 2020 00:18:47
 -0700 (PDT)
Reply-To: mstheresaheidi@yahoo.com
From:   Ms Theresa Heidi <mrswinlyheiditheresa@gmail.com>
Date:   Sun, 30 Aug 2020 02:18:47 -0500
Message-ID: <CAPUuzDa8XZ_tJq=2Gtmi4i1_sw=p99-qLyJnH476E=NdDRwn5g@mail.gmail.com>
Subject: =?UTF-8?B?55eF6Zmi44GL44KJ44Gu57eK5oCl44Gu5omL57SZ?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

6Kaq5oSb44Gq44KL5oSb44GZ44KL5Lq644G444CBDQoNCuaFiOWWhOWvhOS7mOOCiOOBj+OBiuiq
reOBv+OBj+OBoOOBleOBhOOAguOBk+OBruaJi+e0meOBjOaEj+WkluOBq+WxiuOBj+OBruOBr+S6
i+Wun+OBp+OBmeOAguOBneOCjOOBq+OCguOBi+OBi+OCj+OCieOBmuOAgeengeOBr+OBguOBquOB
n+OBq+OBguOBquOBn+OBruazqOaEj+OCkuaJleOBo+OBpuengeOBq+iBnuOBj+OCiOOBhuOBq+is
meiZmuOBq+OBguOBquOBn+OBq+mgvOOBv+OBvuOBmeOAgeengeOBr+engeOBruW/g+OBq+a3seOB
hOaCsuOBl+OBv+OCkuOCguOBo+OBpuOBguOBquOBn+OBq+OBk+OBruODoeODvOODq+OCkuabuOOB
hOOBpuOBhOOBvuOBmeOAgeengeOBr+OCpOODs+OCv+ODvOODjeODg+ODiOOCkuS7i+OBl+OBpuOB
guOBquOBn+OBq+mAo+e1oeOBmeOCi+OBk+OBqOOCkumBuOOBs+OBvuOBl+OBn+ato+ebtOOBquS6
uuOCkuaxguOCgeOBpuOBguOBquOBn+OBruODl+ODreODleOCo+ODvOODq+OAgg0KDQrnp4Hjga7l
kI3liY3jga/jg5/jgrvjgrnjg4bjg6zjgrXjg4/jgqTjgrjjgafjgZnjgILnp4Hjga/nj77lnKjj
g5Xjg6njg7Pjgrnjga7lh7rouqvjgafjgZnjgILnj77lnKjjgIHjgqTjgrnjg6njgqjjg6vjga7n
p4Hnq4vnl4XpmaLjgavogrrjgYzjgpPjgYzljp/lm6DjgaflhaXpmaLjgZfjgabjgYTjgb7jgZnj
gILnp4Hjga82Muats+OBp+OAgee0hDTlubTliY3jgIHlpKvjgYzkuqHjgY/jgarjgaPjgZ/nm7Tl
vozjgavogrrjgYzjgpPjgajoqLrmlq3jgZXjgozjgb7jgZfjgZ/jgIHlvbzjgYzlg43jgYTjgabj
gYTjgZ/jgZnjgbnjgabjgpLnp4Hjgavku7vjgZvjgabjgY/jgozjgb7jgZfjgZ/jgILnp4Hjga/o
grrjgYzjgpPjga7msrvnmYLjgpLlj5fjgZHjgabjgYTjgovnl4XpmaLjga7jg6njg4Pjg5fjg4jj
g4Pjg5fjgpLmjIHjgaPjgabjgYTjgabjgIENCg0K56eB44Gu5Lq655Sf44Gu5pyr5pel44GM6L+R
44Gl44GE44Gm44GE44KL44GT44Go44Gv5piO44KJ44GL44Gn44GZ44CC6IK644GM44KT44Gu44Gf
44KB44GrMeW5tOmWk+OBr+aMgee2muOBl+OBquOBhOOBqOWMu+W4q+OBjOengeOBq+iogOOBo+OB
n+OBruOBp+OAgeengeOBr+S9leOBi+OBruOBn+OCgeOBq+WGjeOBs+OBiumHkeOCkuW/heimgeOB
qOOBl+OBvuOBm+OCk+OAguWVj+mhjOengeOBr+S6oeOBj+OBquOBo+OBn+Wkq+OBi+OCieWPl+OB
kee2meOBhOOBoOOBhOOBj+OBpOOBi+OBruizh+mHkeOAgSQNCjE1MDDkuIfjga7lkIjooYblm73j
g4njg6vvvIhVUyAkIDE1LDAwMCwwMDAsMDDvvInjga7lkIjoqIjjgIENCg0K44GT44Gu44GK6YeR
44Gv44G+44Gg5aSW5Zu944Gu6YqA6KGM44Gr44GC44KK44CB57WM5Za26ICF44Gv56eB44KS55yf
44Gu5omA5pyJ6ICF44Go44GX44Gm56eB44Gr44CB44GK6YeR44KS6ZW344GP5L+d44Gk44Gf44KB
44Gr44GK6YeR44KS5Y+X44GR5Y+W44KL44Gf44KB44Gr5YmN44Gr5p2l44KL44KI44GG44Gr5pu4
44GE44Gf44GL44CB44KA44GX44KN56eB44Gr5Luj44KP44Gj44Gm6Kqw44GL44Gu44Gf44KB44Gr
44Gd44KM44KS5Y+X44GR5Y+W44KL44Gf44KB44Gr6Kqw44GL44Gr5om/6KqN44Gu5omL57SZ44KS
55m66KGM44GX44G+44GX44Gf56eB44Gu55eF5rCX44Gu44Gf44KB44Gr44KE44Gj44Gm44GP44KL
44GL44CB5rKh5Y+O44GV44KM44KL44GL44KC44GX44KM44G+44Gb44KT44CCDQoNCuengeOBq+S9
leOBi+OBjOi1t+OBk+OCi+WJjeOBq+OAgeOBk+OCjOOCieOBruS/oeiol+WfuumHkeOCkuiqoOaE
j+OCkuaMgeOBo+OBpuWHpueQhuOBmeOCi+aEj+aAneOBjOOBguOCi+OBi+OAgeiIiOWRs+OBjOOB
guOCi+OBi+OBqeOBhuOBi+OCkumAo+e1oeOBl+OBvuOBmeOAguOBk+OCjOOBr+ebl+OBvuOCjOOB
n+OBiumHkeOBp+OBr+OBquOBj+OAgeWNsemZuuOBr+OBguOCiuOBvuOBm+OCk+OAgjEwMO+8heOD
quOCueOCr+OBjOOBquOBj+OAgeWujOWFqOOBquazleeahOiovOaLoOOBjOOBguOCiuOBvuOBmeOA
gg0KDQrlpJblm73jga7pioDooYzjgYvjgonjgZPjga7jgYrph5HjgpLlvJXjgY3lh7rjgZnjga7j
gpLmiYvkvJ3jgaPjgabjgoLjgonjgYTjgIHnpL7kvJrjga7mgbXjgb7jgozjgarjgYTkurrjgIXj
gbjjga7mhYjlloTkuovmpa0v5pSv5o+044Gu44Gf44KB44Gu6LOH6YeR44KS5L2/55So44GX44Gm
44GP44Gg44GV44GE44CC44GT44Gu44GK6YeR44GM44GC44Gq44Gf44GM6YG444KT44Gg57WE57mU
44Gr5oqV6LOH44GV44KM44KL44Gu44KS6KaL44Gm56eB44Gu5pyA5b6M44Gu6aGY44GE44Gn44GZ
44CCDQoNCuengeOBr+OBguOBquOBn+OBjOWAi+S6uueahOOBquS9v+eUqOOBruOBn+OCgeOBq+OB
guOBquOBn+OBjOWQiOioiOOBruOBiumHkeOBrjQ177yF44KS5Y+X44GR5Y+W44KL44GT44Go44KS
5pyb44G/44G+44GZ44CB44Gd44GX44Gm44GK6YeR44GuNTXvvIXjgYzmhYjlloTjgavkvb/jgo/j
gozjgovjgafjgZfjgofjgYbjgILnp4Hjga7mnIDlvozjga7poZjjgYTjgpLljbHjgYbjgY/jgZnj
govjgojjgYbjgarjgoLjga7jga/kvZXjgoLmrLLjgZfjgY/jgarjgYTjga7jgafjgIHnp4Hjga7l
v4Pjga7mrLLmnJvjgpLpgZTmiJDjgZnjgovjgZ/jgoHjgavjgZPjga7llY/poYzjgavmnIDlpKfp
mZDjga7mqZ/lr4bmgKfjgajkv6HpoLzjgpLmhJ/orJ3jgZfjgb7jgZnjgIINCg0K44GC44Gq44Gf
44Gu5pyA5oSb44Gu5aa544CCDQrjg4bjg6zjgrXjg4/jgqTjgrjlpKvkuroNCg==
