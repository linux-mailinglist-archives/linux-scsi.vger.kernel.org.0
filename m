Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 762554E87C
	for <lists+linux-scsi@lfdr.de>; Fri, 21 Jun 2019 15:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfFUNHa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 21 Jun 2019 09:07:30 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33759 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfFUNHa (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 21 Jun 2019 09:07:30 -0400
Received: by mail-lj1-f193.google.com with SMTP id h10so5937731ljg.0
        for <linux-scsi@vger.kernel.org>; Fri, 21 Jun 2019 06:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jWa7576rgWVWVSW1745Pn4vugUiYSLxuS7AWMaM+/FQ=;
        b=xoGo+FQp2vZ187gQdSdRprVD4vxPNYjUDtjPAO1IyXa/EuR7uCdQ7DeWaCegKic8As
         isyBoOKpuAuyPKr/2f0AwghYVFts14ArUpmou9WS/9QbyGw6Rf4PQLqF46ydseXryIWF
         JeLm1NkpF4CHvMAlmrNZTAkfkSDvVQe/a7SjPGxUB7eALo4cHbEpWB7G4VdV5qcqry5C
         kfFTS3P81Gy4tv5S+pui7Dz7b7kN0m8pzJlTYVJ5GslUWJyYL8ZRkBVsB6CSahpFg0Z8
         ONGD7t/P4r7+wITdLeBhui0WmxCDiOORu2kzfLfluN6+7PliYReUASKxUO/DrbSNj6Ln
         CHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jWa7576rgWVWVSW1745Pn4vugUiYSLxuS7AWMaM+/FQ=;
        b=Ug9FisPorSA05CE/EwEcBRDHHosT3yoHkOJI9gvH64ej/SilCB5QDKIPRzDvtskFUe
         EnzZ6YIsLs2y1oh74xtGJsqMc8X9FPpELqJXMAGIDIvRqtlzF/+2V5RgwgxJghSrFAjF
         N6hk6JR8SbY4wwoibk2FK2AvRfxqkqM4XXsA2vslSPRSJeRPInzZTeJu5H/KqUzBUV5Y
         4zWysEa3zZiCUBHy/14W20/mYFuxKPLd4kIlNedbszyqBPZd8md9VrMYVZABTjTfNT1M
         KJKLwRI8n6/hLv4vtTjqPNIRLU7y/wydYXjm/hxERQAtW6TKrmP92q9KH0oHAa/EyXwN
         ee9g==
X-Gm-Message-State: APjAAAVGMoula+tAgT32AuuT3usFkjdML5AkK17ddbdSfxYqOqUB5Li5
        EbcgXDEfV/VYMvDhfb/2FtufrA==
X-Google-Smtp-Source: APXvYqzUnlkSIRvoWfskQmErTHxIyFPWo4CsYqd4wu3b2Zwd0KoJS6WozUgI1ufyf4P3BJmOuYo4mA==
X-Received: by 2002:a2e:96d0:: with SMTP id d16mr62786423ljj.14.1561122448747;
        Fri, 21 Jun 2019 06:07:28 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id r2sm387100lfi.51.2019.06.21.06.07.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 06:07:27 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com, hch@lst.de, damien.lemoal@wdc.com,
        chaitanya.kulkarni@wdc.com, dmitry.fomichev@wdc.com,
        ajay.joshi@wdc.com, aravind.ramesh@wdc.com,
        martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        agk@redhat.com, snitzer@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH 0/4] open, close, finish zone support
Date:   Fri, 21 Jun 2019 15:07:07 +0200
Message-Id: <20190621130711.21986-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi,

This patch serie adds support for explicit control of zone transitions.

To test it, one can use an updated blkzone version that is available
here:

  https://github.com/MatiasBjorling/util-linux.git zonemgmt

blkzone can be compiled with:

  ./autogen.sh
  ./configure
  make blkzone

After that, the binary is available in the compile directory.

Regards,
Matias

Ajay Joshi (4):
  block: add zone open, close and finish support
  null_blk: add zone open, close, and finish support
  scsi: sd_zbc: add zone open, close, and finish support
  dm: add zone open, close and finish support

 block/blk-core.c               |  3 ++
 block/blk-zoned.c              | 51 +++++++++++++++++++++---------
 block/ioctl.c                  |  5 ++-
 drivers/block/null_blk.h       |  4 +--
 drivers/block/null_blk_main.c  | 13 ++++++--
 drivers/block/null_blk_zoned.c | 33 ++++++++++++++++++--
 drivers/md/dm-flakey.c         |  7 ++---
 drivers/md/dm-linear.c         |  2 +-
 drivers/md/dm.c                |  5 +--
 drivers/scsi/sd.c              | 15 ++++++++-
 drivers/scsi/sd.h              |  6 ++--
 drivers/scsi/sd_zbc.c          | 18 ++++++++---
 include/linux/blk_types.h      | 35 +++++++++++++++++++--
 include/linux/blkdev.h         | 57 +++++++++++++++++++++++++++++-----
 include/uapi/linux/blkzoned.h  | 17 ++++++++--
 15 files changed, 221 insertions(+), 50 deletions(-)

-- 
2.19.1

