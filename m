Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C025A5EB8B
	for <lists+linux-scsi@lfdr.de>; Wed,  3 Jul 2019 20:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfGCS0B (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 3 Jul 2019 14:26:01 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:43185 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfGCS0B (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 3 Jul 2019 14:26:01 -0400
Received: by mail-io1-f70.google.com with SMTP id y5so3512501ioj.10
        for <linux-scsi@vger.kernel.org>; Wed, 03 Jul 2019 11:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Ol2oTL6I09LrbBugODTrPEcLgmAtDlXO+xFKA9FYWzI=;
        b=KA2ctyWoBIbcIyaFden4nOrTUoTYLpfJ1qv/X6n7mOjVcH6SRF1tU3DtIIyzN/Igq1
         j3JDzCTZgZC8WR56C479pGcZME1ajixJLNow3X+B83WzupA30qbtxVEh/ox9MM9kPj9m
         tJLlsG/Lo2nSKB2ySV3O/UKniT5OBMJxPDrz7h3JT83ICySqO1ydyNbSPzLHpICR4r3Z
         EHlaLqdNabY5sq69JBQ9NjSkNAIlz6uHhtMi4hG/+7/vhB7K2Gf9nLdXy+dHGouYrhu9
         KgGInaSFRuneWT/1N63NEDEQOdRtwV3f4mlnCEpiRrLPdcD34OG1kpqJZu63w8Be1AcZ
         uHiw==
X-Gm-Message-State: APjAAAVN+h3LQR6xyNRYhNBNIJD0FJRE4yiutc8A6B2AR5De2Dr15yC7
        Fz4A6UIB/cgqT7AT+U316U1JshTPpU0lyUpxOkJVmMo0ezwe
X-Google-Smtp-Source: APXvYqwnKz9Y5ErGzM/oENrZog1dO7eB2V3AocjmtCzYXUDUaLNQ1kAbKUGqE/0CNl8wQiJx3GqOLtHaUDhnnEPnEz2HNfDxKgvN
MIME-Version: 1.0
X-Received: by 2002:a02:c50a:: with SMTP id s10mr45090759jam.106.1562178360550;
 Wed, 03 Jul 2019 11:26:00 -0700 (PDT)
Date:   Wed, 03 Jul 2019 11:26:00 -0700
In-Reply-To: <00000000000035c756058848954a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000041ac74058ccafe0d@google.com>
Subject: Re: KASAN: use-after-free Read in hci_cmd_timeout
From:   syzbot <syzbot+19a9f729f05272857487@syzkaller.appspotmail.com>
To:     chaitra.basappa@broadcom.com, davem@davemloft.net,
        jejb@linux.vnet.ibm.com, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, marcel@holtmann.org,
        martin.petersen@oracle.com, mpt-fusionlinux.pdl@broadcom.com,
        netdev@vger.kernel.org, sathya.prakash@broadcom.com,
        suganath-prabu.subramani@broadcom.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

syzbot has bisected this bug to:

commit ff92b9dd9268507e23fc10cc4341626cef50367c
Author: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Date:   Thu Oct 25 14:03:40 2018 +0000

     scsi: mpt3sas: Update MPI headers to support Aero controllers

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=130ac8dda00000
start commit:   eca94432 Bluetooth: Fix faulty expression for minimum encr..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=108ac8dda00000
console output: https://syzkaller.appspot.com/x/log.txt?x=170ac8dda00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6451f0da3d42d53
dashboard link: https://syzkaller.appspot.com/bug?extid=19a9f729f05272857487
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125b7999a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=176deefba00000

Reported-by: syzbot+19a9f729f05272857487@syzkaller.appspotmail.com
Fixes: ff92b9dd9268 ("scsi: mpt3sas: Update MPI headers to support Aero  
controllers")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
