Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE13A158167
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Feb 2020 18:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgBJRcI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 10 Feb 2020 12:32:08 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:35213 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBJRcI (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 10 Feb 2020 12:32:08 -0500
Received: by mail-wr1-f51.google.com with SMTP id w12so8853932wrt.2
        for <linux-scsi@vger.kernel.org>; Mon, 10 Feb 2020 09:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wwwVnTsNQ885OgDQxeYSbvwz5nCtQbOMZJ2giAvlEIQ=;
        b=Ek3QFP2yRvCdpax35ZozuoTwTbdB0d4hcyUFSTWFWe0ZBkWwgMw7ZIZlUZtgvL7BF+
         YMMpXKPGKG1xeucKoVgXprwvQ6I921xV7R3uR+SzGFtsDJciq7Sfj6vcJrCEZ0Ot/uxa
         tCJbRUh9/7GmjcYtfj9ahr31WkNM20p6rKVagK/LJLvFoGOx/IxJ7No7r9hygHf2pheX
         nmj54gyE7od4I0dG8tbQujwZlSVT60X2KSAzifJFROznT5FFL8w8IIIlehYM3K4sHaIM
         dieFxxcPRz+n053VFD7fYDC53/IcxS7whryxIds3TIzHpcm08e12BN3SoLR4IjEp35mF
         MhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wwwVnTsNQ885OgDQxeYSbvwz5nCtQbOMZJ2giAvlEIQ=;
        b=RRih01pK/qo2lIuKXUddhu3JXOhXTxPI80y0rQNIvmivn5DpKYgmlfT2/N1x394see
         gH4R61dhdjkYhXG/+sBzaJNwNaQr4GpP6sQjTlrfjPo0H6FwrHH2Tv6nu1nQOv0o6T4U
         6rv6FlA5G6Eozj2RbFvpjAbeWSM3uNpapYbpZ61PmYlm3/G450JkCVCIn5cAkFkcMyEx
         JLRpxsZ05PhvKCmI/l8UVSTgqGtGI1WiCYDG2YOyyeYcw8xI6lgiUZMi8BGDSmYZQBK1
         NMZ4wtsZWrJr+dG81Y4tIEd8lKPh5AOUX0xtMrkmB2IyMXuNxHjYYTtpUkhgBTiA/dxj
         KeOA==
X-Gm-Message-State: APjAAAUe4HKCu6A3vFaz6GHtSCwiynU0iVxB5QTUgUvniCUexSHmgkzi
        dhYRWdTgwrt98zOLZ/Ve7xUt5INp
X-Google-Smtp-Source: APXvYqzJ+CPjnpXQuNn79CsKQYpW3Jct/3L0Q07G7B1ydGVEvteO4q/JwY6betK+C5i6g8cdnck+eA==
X-Received: by 2002:adf:a1d9:: with SMTP id v25mr3016683wrv.160.1581355926280;
        Mon, 10 Feb 2020 09:32:06 -0800 (PST)
Received: from os42.localdomain ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id k10sm1402135wrd.68.2020.02.10.09.32.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Feb 2020 09:32:05 -0800 (PST)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>
Subject: [PATCH v2 0/2] lpfc: Add Link Integrity FPIN registration and logging
Date:   Mon, 10 Feb 2020 09:31:53 -0800
Message-Id: <20200210173155.547-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch adds the RDF ELS to the driver to register to receive Link
Integrity FPINs from the fabric.  The driver also adds logging of the
elements contained in the FPIN before delivering it to the scsi fc
transport.

As part of the patch, the uapi/scsi/fc/fc_els.h header is updated with
the FC standards definitions for the RDF and FPIN ELS and their components.

This patch was cut against 5.7/scsi-queue

v2:
  minor mods to patch 2: indentiation change; and slight structure
    reference change.

James Smart (2):
  fc: Update Descriptor definition and add RDF and Link Integrity FPINs
  lpfc: add RDF registration and Link Integrity FPIN logging

 drivers/scsi/lpfc/lpfc.h         |  29 ++++
 drivers/scsi/lpfc/lpfc_crtn.h    |   3 +-
 drivers/scsi/lpfc/lpfc_els.c     | 324 ++++++++++++++++++++++++++++++++++++---
 drivers/scsi/lpfc/lpfc_hbadisc.c |   4 +-
 drivers/scsi/lpfc/lpfc_hw.h      |   4 +-
 drivers/scsi/lpfc/lpfc_hw4.h     |  19 +++
 drivers/scsi/lpfc/lpfc_sli.c     |   1 +
 include/uapi/scsi/fc/fc_els.h    | 211 +++++++++++++++++++++++--
 8 files changed, 557 insertions(+), 38 deletions(-)

-- 
2.13.7

