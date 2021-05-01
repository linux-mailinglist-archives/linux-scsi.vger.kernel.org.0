Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D83537090B
	for <lists+linux-scsi@lfdr.de>; Sat,  1 May 2021 23:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbhEAVTC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 1 May 2021 17:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhEAVTB (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 1 May 2021 17:19:01 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCE1C06174A
        for <linux-scsi@vger.kernel.org>; Sat,  1 May 2021 14:18:11 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id f15so1117773qtv.5
        for <linux-scsi@vger.kernel.org>; Sat, 01 May 2021 14:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=MK1JNYymHNZjAuSw7w569yYJuYIhIGNffTSHi9WTjH0=;
        b=PdTJYaWHkGsHXkBZ2XNXmuZdm7uGd5eQKBUCtJI7Sa1Dsb9j0Oht9MiyHVwtFV9efH
         tDykQD/R7837EMCh0Cd95pnWQcQ1eBV/ZKVTQHMxHGTD6lsBSB9ou0PS/qb/lmBRtHRS
         OCidSWmHzB66M0wEfbZ3OSPQsnCO8TaiXHcE4ColO+YTPlAHu5N/rnfqiQqu5cX58sXK
         su+90yYm5LOvdv6totzKsGehjiArTeSNVPfFAGIeY9UR/YFlNBYheQcdKKiHp7jaZuzh
         xuEyXQfjeJ+avv0olqG8+XpPnRIzDmxRwtQjz9K0eSf6aCL/H58q68Me0y5cAiSkX0q5
         bLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=MK1JNYymHNZjAuSw7w569yYJuYIhIGNffTSHi9WTjH0=;
        b=T3TngeU402aDZgonuJHFVtecDJ6a7YBmtnVaJyicQOwtsFLEu8l+ERbW/hRzDF2bnS
         9QtH2dH0lLilL44aUgwYbTDiXgTV59a2KUs2spga8NZ38oUHEPfpqxu6UYVnjGsAECz/
         bGO9Q7Q54KYiG6Fq+gLVsaKD7+ykvUirHGXBnYV5DuC2FcJgSvgV/IYdlxwVrlsE2EmD
         WzsgOdGXTXR6+27gAghjij7Bkp+97BZe/stCqyENz8mWgnsjZiSkaH1y34kecanqGHvO
         SsZ5Fu1f8XV9qN/mgJ1kJbmPcyr6Od8uS+toAsz+8ST8ZjXo5UMNrnFfZnanSPEoHvGz
         1/wQ==
X-Gm-Message-State: AOAM530g3IlxkiDs/7s5od+eXqmT3qAWdWiowpxm/wuFWxODOU/y7B+2
        Fu/VkYDpXpfKoZGd30azF8cQhf/WY+dYWQ7TUNg=
X-Google-Smtp-Source: ABdhPJwdXFnypcXvUWEaOeRrtRk3r/zGr2jNyebHtmtril6l4zNTgcWFhGlxOG+lOlu5mVwI2L6E2GLmRUG6M0H2n6k=
X-Received: by 2002:ac8:5704:: with SMTP id 4mr9985228qtw.379.1619903890563;
 Sat, 01 May 2021 14:18:10 -0700 (PDT)
MIME-Version: 1.0
Sender: assilatamchistian@gmail.com
Received: by 2002:a0c:e04a:0:0:0:0:0 with HTTP; Sat, 1 May 2021 14:18:10 -0700 (PDT)
From:   Kayla manthey <sgtmanthey1@gmail.com>
Date:   Sat, 1 May 2021 21:18:10 +0000
X-Google-Sender-Auth: 56Iqs-FtjoYtHT6aURQ73xQP87k
Message-ID: <CA+i7vmE8q4Ev5HJtuu8Bn=5ftFTJgNqv6U5YmkVJcf8kxU7b-Q@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

K=C3=A9rem, szeretn=C3=A9m tudni, hogy megkapta-e az el=C5=91z=C5=91 =C3=BC=
zeneteimet.
