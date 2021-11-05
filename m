Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5AF445DFD
	for <lists+linux-scsi@lfdr.de>; Fri,  5 Nov 2021 03:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhKECf7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 4 Nov 2021 22:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhKECf7 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 4 Nov 2021 22:35:59 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546A2C061714
        for <linux-scsi@vger.kernel.org>; Thu,  4 Nov 2021 19:33:20 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id o18so15781953lfu.13
        for <linux-scsi@vger.kernel.org>; Thu, 04 Nov 2021 19:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=o/wF/V9TAVPEMQT2oLx1JVaew2djn3pZBY/upXLYuzc=;
        b=GHpARzBoc3z/GsbFqrJCUrognspJ9m9qQ1sj0wcXiZge8xxxr+jTrMTOztjbycnI/7
         NHnSqexQjrRoOmLcDknkrM8cry6B90geRSP2tgz4Gecfu0siRipJYdmrIlXERou7RMhT
         lzhvHCzskfzOE3Mekrc/1PkmhdDuz3uZVYTPK5qNKsnueHcgWCCX4Vg3t/E3/r0MzztR
         HTUR+h35WMLm+x6LPLCUvrHbHGsFD5trcEoptWMmHVv8KAF/dDyO6d++homNebX3ivdb
         ISYJgmQ4wmKzgRN6FfPnCGOrmsfkQAbUKl89A+W2glZSmwMyCbofK4MZlZT+sw+GOCSh
         n6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=o/wF/V9TAVPEMQT2oLx1JVaew2djn3pZBY/upXLYuzc=;
        b=BVmakhIibEvLJA10TaBrf4BdH7Icv2gXE4DCuPAfX3IRAgmHOLKzTtqFwPUPDb34m0
         0TXsS71X4TaNSFUt8ql2ugaZSQKnLb/3YkIXeDcsR2YA1dXFd+GKhtP0R2itqxejTlRs
         9i06FlqpkEGiIfFqfa2KutlQZKddf4lIftVK1/ruw6A5mbldTZ9YDD3UAqVaK1sxOIAq
         lR/nAmqj4e9zYLOuUMCNkE1SpIVmbf/S8UIGqMglgc7o2ntT7iccj0tsjWVOvuJXsHuc
         UYSXq8dc0OdxUPRsf1Sp4G/izoeQaG1nd286r8aHyN3JhNqnVuJ8ryFlUPHsXGbpEyv2
         w9gA==
X-Gm-Message-State: AOAM5306/zx603ONBqg9l+FMxs6lrHQ3Q+ThBhHoB+AwsC9htmiu7uK/
        Rhc6pSarfrbT5RvTgiNLH92/zro1QXe9DzREa1s=
X-Google-Smtp-Source: ABdhPJwOk443/Wx7zXIdaTNzHesyOo1vEVSG65yR+Kp0G5P7UeBNNTlCFENt9G1ribS0vqx4q5fu6ifRWJHK8FDLVOY=
X-Received: by 2002:ac2:4859:: with SMTP id 25mr8117600lfy.112.1636079598533;
 Thu, 04 Nov 2021 19:33:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6512:32c6:0:0:0:0 with HTTP; Thu, 4 Nov 2021 19:33:18
 -0700 (PDT)
Reply-To: mstheresaheidi8@gmail.com
From:   Ms Theresa Heidi <hennagercjames@gmail.com>
Date:   Fri, 5 Nov 2021 02:33:18 +0000
Message-ID: <CAMhtcvhrN_4Z9ZxgtGLP1H0Lvv3+M5iQNxOqXDEbBVFbNvHVTQ@mail.gmail.com>
Subject: =?UTF-8?B?55eF6Zmi44GL44KJ44Gu57eK5oCl44Gu5Yqp44GR77yB?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

6Kaq5oSb44Gq44KL5oSb44GZ44KL5Lq644CBDQoNCuaFiOWWhOWvhOS7mOOBk+OBruaJi+e0meOB
jOOBguOBquOBn+OBq+mpmuOBjeOBqOOBl+OBpuadpeOCi+OBi+OCguOBl+OCjOOBquOBhOOBk+OB
qOOBr+eiuuOBi+OBp+OBmeOAgeazqOaEj+a3seOBj+iqreOCk+OBp+OBj+OBoOOBleOBhOOAguen
geOBr+OBguOBquOBn+OBruaPtOWKqeOCkuW/heimgeOBqOOBl+OBpuOBhOOCi+mWk+OBq+engeea
hOOBquaknOe0ouOCkumAmuOBl+OBpuOBguOBquOBn+OBrumbu+WtkOODoeODvOODq+OBrumAo+e1
oeWFiOOBq+WHuuOBj+OCj+OBl+OBvuOBl+OBn+OAguengeOBr+W/g+OBi+OCieaCsuOBl+OBv+OC
kui+vOOCgeOBpuOBk+OBruODoeODvOODq+OCkuabuOOBhOOBpuOBhOOBvuOBmeOAguOCpOODs+OC
v+ODvOODjeODg+ODiOOBjOS+neeEtuOBqOOBl+OBpuacgOmAn+OBruOCs+ODn+ODpeODi+OCseOD
vOOCt+ODp+ODs+aJi+auteOBp+OBguOCi+OBn+OCgeOAgeOCpOODs+OCv+ODvOODjeODg+ODiOOC
kuS7i+OBl+OBpuOBguOBquOBn+OBq+mAo+e1oeOBmeOCi+OBk+OBqOOCkumBuOaKnuOBl+OBvuOB
l+OBn+OAgg0KDQrnp4Hjga7lkI3liY3jga/jg4bjg6zjgrXjg7vjg4/jgqTjgrjlpKvkurrjgafj
gZnnp4Hjga/nj77lnKjjgIHnp4HjgYw2Muats+OBruiCuueZjOOBrue1kOaenOOBqOOBl+OBpuOC
pOOCueODqeOCqOODq+OBruengeeri+eXhemZouOBq+WFpemZouOBl+OBpuOBiuOCiuOAgeengeOB
r+e0hDTlubTliY3jgIHlpKvjga7mrbvlvozjgZnjgZDjgavogrrjgYzjgpPjgajoqLrmlq3jgZXj
gozjgb7jgZfjgZ/jgILnp4Hjga/ogrrjga7nmYzjga7msrvnmYLjgpLlj5fjgZHjgabjgYTjgovj
gZPjgZPjga7nl4XpmaLjgafnp4Hjga7jg6njg4Pjg5fjg4jjg4Pjg5fjgajkuIDnt5LjgavjgYTj
gb7jgZnjgILnp4Hjga/kuqHjgY3lpKvjgYvjgonlj5fjgZHntpnjgYTjgaDos4fph5HjgpLmjIHj
gaPjgabjgYTjgb7jgZnjgYzjgIHlkIjoqIjjga8yNTDkuIfjg4njg6soMiw1MDAsMDAwLDAwMOex
s+ODieODqynjgafjgZnjgILku4rjgIHnp4Hjga/np4Hjga7kurrnlJ/jga7mnIDlvozjga7ml6Xj
gavov5HjgaXjgYTjgabjgYTjgovjgZPjgajjga/mmI7jgonjgYvjgafjgYLjgorjgIHnp4Hjga/j
goLjgYbjgZPjga7jgYrph5HjgpLlv4XopoHjgajjgZfjgarjgYTjgajmgJ3jgYTjgb7jgZnjgILn
p4Hjga7ljLvogIXjga/jgIHnp4HjgYzogrrnmYzjga7llY/poYzjga7jgZ/jgoHjgasx5bm06ZaT
57aa44GL44Gq44GE44GT44Go44KS56eB44Gr55CG6Kej44GV44Gb44G+44GX44Gf44CCDQoNCuOB
k+OBruOBiumHkeOBr+OBvuOBoOWkluWbveOBrumKgOihjOOBq+OBguOCiuOAgee1jOWWtuiAheOB
r+engeOCkuacrOW9k+OBruaJgOacieiAheOBqOOBl+OBpuOAgeOBiumHkeOCkuWPl+OBkeWPluOC
i+OBn+OCgeOBq+WJjeOBq+WHuuOBpuadpeOCi+OBi+OAgeeXheawl+OBruOBn+OCgeOBq+adpeOC
i+OBk+OBqOOBjOOBp+OBjeOBquOBhOOBruOBp+engeOBq+S7o+OCj+OBo+OBpuiqsOOBi+OBq+OB
neOCjOOCkuWPl+OBkeWPluOCi+OBn+OCgeOBruaJv+iqjeabuOOCkueZuuihjOOBmeOCi+OCiOOB
huOBq+abuOOBhOOBn+OAgumKgOihjOOBruihjOWLleOBq+WkseaVl+OBmeOCi+OBqOOAgeOBneOC
jOOCkumVt+OBj+e2reaMgeOBl+OBn+OBn+OCgeOBq+izh+mHkeOBjOayoeWPjuOBleOCjOOCi+WP
r+iDveaAp+OBjOOBguOCiuOBvuOBmeOAgg0KDQrnp4HjgYzlpJblm73jga7pioDooYzjgYvjgonj
gZPjga7jgYrph5HjgpLlvJXjgY3lh7rjgZnjga7jgpLmiYvkvJ3jgaPjgabjgY/jgozjgovjgarj
gonjgIHjgYLjgarjgZ/jgavpgKPntaHjgZnjgovjgZPjgajjgavjgZfjgb7jgZfjgZ/jgILjgZ3j
gZfjgabjgIHmhYjlloTmtLvli5Xjga7jgZ/jgoHjga7os4fph5HjgpLkvb/jgaPjgabjgIHmgbXj
gb7jgozjgarjgYTkurrjgIXjgpLliqnjgZHjgIHnpL7kvJrjga5Db3ZpZC0xOeODkeODs+ODh+OD
n+ODg+OCr+OBqOaIpuOBhuOBk+OBqOOCguOBp+OBjeOBvuOBmeOAguengeOBq+S9leOBi+OBjOi1
t+OBk+OCi+WJjeOBq+OAgeOBk+OCjOOCieOBruS/oeiol+WfuumHkeOCkuiqoOWun+OBq+aJseOB
o+OBpuOBu+OBl+OBhOOAguOBk+OCjOOBr+ebl+OBvuOCjOOBn+OBiumHkeOBp+OBr+OBquOBj+OA
geWujOWFqOOBquazleeahOiovOaLoOOBjOOBguOCjOOBsDEwMO+8heODquOCueOCr+OBjOOBquOB
hOOBqOOBhOOBhuWNsemZuuOBr+OBguOCiuOBvuOBm+OCk+OAgg0KDQrnp4Hjga/jgYLjgarjgZ/j
gavjgYLjgarjgZ/jga7lgIvkurrnmoTjgarkvb/nlKjjga7jgZ/jgoHjga7nt4/jgYrph5Hjga40
NSXjgpLlj5bjgaPjgabjgbvjgZfjgYTjgYzjgIHjgYrph5Hjga41NSXjga/mhYjlloTmtLvli5Xj
gavooYzjgY/jgILnp4Hjga/np4Hjga7mnIDlvozjga7poZjjgYTjgpLljbHpmbrjgavjgZXjgonj
gZnjgoLjga7jgpLmnJvjgpPjgafjgYTjgarjgYTjga7jgafjgIHnp4Hjga/np4Hjga7lv4Pjga7m
rLLmnJvjgpLpgZTmiJDjgZnjgovjgZ/jgoHjgavjgIHjgZPjga7llY/poYzjgafjgYLjgarjgZ/j
ga7mnIDlpKfpmZDjga7kv6HpoLzjgajmqZ/lr4bmgKfjgavmhJ/orJ3jgZfjgb7jgZnjgILjgYLj
garjgZ/jga7jgrnjg5Hjg6DjgafjgZPjga7miYvntJnjgpLlj5fjgZHlj5bjgaPjgZ/loLTlkIjj
gIHnp4Hjga/pnZ7luLjjgavnlLPjgZfoqLPjgYLjgorjgb7jgZvjgpPjgYzjgIHlm73jga7mnIDo
v5Hjga7mjqXntprjgqjjg6njg7zjgavjgojjgovjgoLjga7jgafjgZnjgIINCg0K44GC44Gq44Gf
44Gu5pyA5oSb44Gu5aeJ5aa544CCDQrjg4bjg6zjgrXjg7vjg4/jgqTjgrjlpKvkuroNCg==
