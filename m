Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A672FD0E6
	for <lists+linux-scsi@lfdr.de>; Thu, 14 Nov 2019 23:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfKNWZk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 14 Nov 2019 17:25:40 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35682 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfKNWZk (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 14 Nov 2019 17:25:40 -0500
Received: by mail-wm1-f66.google.com with SMTP id 8so8129839wmo.0;
        Thu, 14 Nov 2019 14:25:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cljoSUfiSTROdYypCtIKlYf7saFWg/3fUsNmQma9Nks=;
        b=HFFNtX0kj6x3hPK6Nj+hOqXI4AyTnEcvrWqbbyIQu2d1RF2BWHmg1yty0AC0aiya15
         KrVp5EBS/nZPuK0WyjjV4Rz1fGkQQunvZQOpRE8mlxWJjT6rowkCS7Ync+XUo6zxDQ8F
         TUsB1ye+Gfk+JBIh128uXOMR871nRIA1N4qKyfNgmUN/PvdG3oMWafv2m8UbOzyV/PSQ
         VdSHmcZYn2SXE4L2TPSCj2KMPREK+lRGccttwDsFmu0DJm6/nHDBGFipUgIukxr79o42
         S/NQtpC1qHv9y688CiWtNHN9+WfhpIa96TD7z0JFJhc1SgZEE7Qjd3KC8XhnCHcK0HpD
         OkRw==
X-Gm-Message-State: APjAAAX2VLcA0l2c7cZc5VwS5s9Y4BRpYB0B/qIu/uBBh5kz+R+kFvFb
        tWR3ebWBMuY7Pipo1YLMK6w=
X-Google-Smtp-Source: APXvYqx695BV7Zm8Ky82oyapOZPVhFwPQiuUPiwpl//QzxSlzozgSS3LbrRxj5GQKP7YyAuQxOafzg==
X-Received: by 2002:a05:600c:2103:: with SMTP id u3mr11672313wml.150.1573770337911;
        Thu, 14 Nov 2019 14:25:37 -0800 (PST)
Received: from localhost.localdomain (2001-1c06-18c6-e000-0cda-4949-05a4-23b4.cable.dynamic.v6.ziggo.nl. [2001:1c06:18c6:e000:cda:4949:5a4:23b4])
        by smtp.gmail.com with ESMTPSA id d11sm8814903wrn.28.2019.11.14.14.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 14:25:37 -0800 (PST)
From:   Kars de Jong <jongk@linux-m68k.org>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>
Cc:     linux-scsi@vger.kernel.org, linux-m68k@vger.kernel.org,
        schmitzmic@gmail.com, fthain@telegraphics.com.au,
        Kars de Jong <jongk@linux-m68k.org>
Subject: [PATCH v3 0/2] Some esp_scsi updates
Date:   Thu, 14 Nov 2019 23:25:16 +0100
Message-Id: <20191114222518.2441-1-jongk@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191114215956.21767-1-jongk@linux-m68k.org>
References: <20191114215956.21767-1-jongk@linux-m68k.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

When trying kernel 5.4.0-rc5 on my Amiga, I experienced data transfer failures
when reading from my FAST-10 SCSI disk. I have a Blizzard 12x0 IV SCSI
controller which uses a Symbios Logic SYM53CF94-2 "FSC" chip.

This used to work with the old generic NCR53C9x driver, so I investigated the
issue.

It turned out to be caused by lacking detection of FSC silicon in the new
driver.

The second patch in this series adds support for the FSC.

When adding support for the chip, I found out the hard way that the esp_rev
enum is ordered (I just added it to the end of the enum).

Then I also discovered that the definition for the PCSCSI chip was in the wrong
place of the enum. It will probably have issues with FAST-10 SCSI targets,
because its CONFIG3 settings are wrong.

The first patch fixes this, and adds comments to the enum to hopefully prevent
this from happening again.

When discussing this on the Linux/m68k mailing list, it was suggested to
perhaps replace the dependency on ordering of the esp_rev enum by feature flags.
I did not implement this for now.

Changes since v1:
- Removed confusing comments from esp_rev enum
- Remove unneeded definitions for UID register
- Remove unneeded local uid variable

Changes since v2:
- Fixed merge conflict in second patch

Kars de Jong (2):
  esp_scsi: Correct ordering of PCSCSI definition in esp_rev enum
  esp_scsi: Add support for FSC chip

 drivers/scsi/esp_scsi.c | 21 +++++++++++++--------
 drivers/scsi/esp_scsi.h | 41 +++++++++++++++++++++++++----------------
 2 files changed, 38 insertions(+), 24 deletions(-)

-- 
2.17.1

