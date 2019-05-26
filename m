Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C13292AA8A
	for <lists+linux-scsi@lfdr.de>; Sun, 26 May 2019 17:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfEZPvi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 26 May 2019 11:51:38 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:34085 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbfEZPvi (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 26 May 2019 11:51:38 -0400
Received: by mail-ed1-f47.google.com with SMTP id p27so22746039eda.1
        for <linux-scsi@vger.kernel.org>; Sun, 26 May 2019 08:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmd.nu; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=6u+mBihjgo4HKm0ZC9WQS3i2jEba5nVMLYtiG1fjxnk=;
        b=NNg1fQ/QCuvjsAdV8Lrtf2BFCf9H81Kz/VVSC91LzHSBb4qgRgm7f3w14TdwKzLWc8
         rXjLXsPYDgwqVlN3KjvP9WAa/CPhF9Ie1y+RXbsMGrpkVZ0KeEYq9MdGCIMlitggq72C
         npB/qE6qJDZKvnxmmLW9Tx/Dvq55Ya2pvlrAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6u+mBihjgo4HKm0ZC9WQS3i2jEba5nVMLYtiG1fjxnk=;
        b=glyMkuAgLOMs7TUKt08XNEq8oX0B+nPIiT+Lek+z6ZZ/v76FRePaQexbNMe5JQj7nw
         QTLYF4rpTJ9xQ0mPefU47u6ti3NxrWikITjIfuVOBzpjBBjxmcFrIlOtxxYUraoyK4FL
         ZFb6nSsXn1r8d7a6pwoi9irUBf3CkzOk+V6KfarEHxqIOqpj2qBBnzrEjEYAurUe++nt
         CJKxfSWPNlX3jcjPgnVsjnVZI9itTDBYcjBcXdrwBvig3H4JPUWB8iRy6hAAtuYp+0a0
         dUFMRcSc1fhbPFTbTuqC+nsNCuD9YFJavUWN8iDW0ZDB/q92WuS/+nN4B0Msf2SHHISX
         lfRQ==
X-Gm-Message-State: APjAAAVLj2FgrQmz50bYIO5IpXzOJXat87pxQWqVWT/HIUGCbeP7Avm0
        4n/x+hoc1F33CIjthm7d+UfSxy/anL0dJkMwXZ4Ir2ZmtinlfA==
X-Google-Smtp-Source: APXvYqxymtv2yI/oyRo1BIo5LVMuBycfWVSzrnroDeiI590G2nnPDdxFUGmW2V+lHYHp0iitsoqTM1nghjIX7cTsF18=
X-Received: by 2002:a50:918b:: with SMTP id g11mr117751461eda.24.1558885895785;
 Sun, 26 May 2019 08:51:35 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Svensson <christian@cmd.nu>
Date:   Sun, 26 May 2019 17:51:25 +0200
Message-ID: <CADiuDASOCJbnwLs-LEp0aCX+T4dMvFfKQv_zsypHW-iSF8wW=Q@mail.gmail.com>
Subject: FICON target support
To:     linux-scsi@vger.kernel.org
Cc:     fcoe-devel@open-fcoe.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi,

I am doing some preliminary scouting of how one could add support for
FICON (FC-SB-3 specifically). I am mostly interested in Linux being
able to act as a FICON target for now.

The TL;DR summary for FICON is that it uses Fibre Channel just like FCP/SCSI
up to but not including the FC-4 (FCP) layer. At that point it uses its own
SBCCS layer.

FICON is used by IBM mainframes to interface peripherals like tape, disk,
printers, card punchers/readers, etc. It is more like a mainframe USB/Firewire
than SCSI in that regard.

I would prefer to implement my peripherals in user-space, I don't see any
convincing case for having e.g. a virtual tape drive running in kernel space.
The I/O heavy disks would probably benefit from being in kernel space, but I am
OK limiting the initial scope.

I am 100% new to the SCSI and Fibre Channel subsystem in Linux, and I
do not even know if the current HBAs support sending frames without FCP
but after scouting the code it does seem that it might work out - FCP
seems decoupled enough.

If you want to learn more the standard document Wireshark has an
implementation of the protocol (packet-fcsb3.c/h). If you want all the details
you will sadly have to pay $60 and buy it from INCITS at
https://webstore.ansi.org/Standards/INCITS/INCITS3742003S2013.
Fwiw, FICON uses FC type 0x1B and 0x1C.

Any thoughts or ideas where you would start? Do you see any future for this
addition to the kernel?

Thanks in advance,
Chris
