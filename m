Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C83768057D
	for <lists+linux-scsi@lfdr.de>; Sat,  3 Aug 2019 11:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387995AbfHCJKs (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 3 Aug 2019 05:10:48 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:36230 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387730AbfHCJKs (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 3 Aug 2019 05:10:48 -0400
Received: by mail-qt1-f173.google.com with SMTP id z4so76486675qtc.3
        for <linux-scsi@vger.kernel.org>; Sat, 03 Aug 2019 02:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=Gm2dij4mV6+WhXehQstbnX0dBMHnBu3lMZ3v1HK+VF4=;
        b=pA4I0CsYbQ+1vLeL6j5N0qmwVK3vbQr2ROu+0WMjBCrIvw7i/qLoLhpL3gZC5oFyvo
         D8InH/VnZPlEW4W1kJUW3kFYpLkX3pi8AU++fS4+Lwqc4TIOT/KZL2sOR58GuxfjhXBD
         cq2oU8Y+w0SuGEdWQF6o3suq0FHJegLcPsyFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=Gm2dij4mV6+WhXehQstbnX0dBMHnBu3lMZ3v1HK+VF4=;
        b=CaosyBJWXxZZmO4RESAVcmHKMWVJHCEtjvil7iuPZFN7S9J6nZ/cKNVpo6A2kRPnt7
         8OSMyP6MOHkujO1Dwl8/9Mp/zEE/YV9Iwu5FLwCQYsKuklAoNmyQvRZqan7JWGWqkM1P
         39FteGg3+UVjgOnkV8GYT3l0RfgMg9zIELl3yIrFe4I0nLiHfmZyHIlLvBALB4jhLUcF
         MjsWbFwASBQISYPVjWpMms+Fma4DPIxwVDF/EVwV4onTXuooQ5UGraJNAvXMFzPfTDRH
         zL0E2gNEaN7Aw/wEWSRdYyIWgBWqvTOZzdz1Q8UBJHQqu7vYsHc7cVrz6UCxTt0Ntjug
         1hVw==
X-Gm-Message-State: APjAAAWIvLPvZwfEMTBtLFIqQYDWol2N9nku269qGiMAakDLzsJdV7MN
        jFIAlFB67Ty5mjjnXp5ewZI=
X-Google-Smtp-Source: APXvYqwiXp4Sjrh3NZUnIYNLnPEbwcdhIRnDFNn+4raq2CSzD+Awp8dA7fUTsyR3/qdX9I+x+Ah6pw==
X-Received: by 2002:ac8:2baa:: with SMTP id m39mr100092554qtm.242.1564823447119;
        Sat, 03 Aug 2019 02:10:47 -0700 (PDT)
Received: from WARPC (pool-173-72-201-135.clppva.fios.verizon.net. [173.72.201.135])
        by smtp.gmail.com with ESMTPSA id r17sm35011821qtf.26.2019.08.03.02.10.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 02:10:46 -0700 (PDT)
From:   "Justin Piszcz" <jpiszcz@lucidpixels.com>
To:     "'LKML'" <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: 5.2.x kernel: WD 8TB USB Drives: Unaligned partial completion (resid=78, sector_sz=512)
Date:   Sat, 3 Aug 2019 05:10:44 -0400
Message-ID: <006d01d549db$54e42140$feac63c0$@lucidpixels.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AdVJ2z/+9mq0jIkOQpG4zabX2Rwi3A==
Content-Language: en-us
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Attached 2 x brand new Western Digital 8TB USB 3.0 drives awhile back =
and
ran some file copy tests and was getting these warnings-- is there any =
way
to avoid these warnings?=A0 I did confirm with parted that the partition =
was
aligned but this appears to be something related to the firmware on the
device according to [1] and [2]?

[1]=A0https://patchwork.kernel.org/patch/9573203/
[2] https://patchwork.kernel.org/patch/9597797/

Part of the patch in [2] - if the firmware is buggy is there a patch or
workaround for these drives (when used in the USB enclosures) to avoid =
this
issue?

+	default:
+		/*
+		 * In case of bogus fw or device, we could end up having
+		 * an unaligned partial completion. Check this here and
force
+		 * alignment.
+		 */
+		resid =3D scsi_get_resid(SCpnt);
+		if (resid & (sector_size - 1)) {
+			sd_printk(KERN_INFO, sdkp,
+				"Unaligned partial completion (resid=3D%u,
sector_sz=3D%u)\n",
+				resid, sector_size);
+			resid =3D min(scsi_bufflen(SCpnt),
+				    round_up(resid, sector_size));
+			scsi_set_resid(SCpnt, resid);
+		}

Errors:

Jul 18 16:25:02 name kernel: [87305.605993] sd 8:0:0:0: [sdg] Unaligned
partial completion (resid=3D78, sector_sz=3D512)
Jul 18 16:25:02 name=A0kernel: [87305.605993] sd 8:0:0:0: [sdg] =
Unaligned
partial completion (resid=3D78, sector_sz=3D512)

Jul 18 16:25:15 name=A0kernel: [87318.292262] sd 7:0:0:0: [sdf] =
Unaligned
partial completion (resid=3D78, sector_sz=3D512)
Jul 18 16:25:15 name=A0kernel: [87318.292262] sd 7:0:0:0: [sdf] =
Unaligned
partial completion (resid=3D78, sector_sz=3D512)


