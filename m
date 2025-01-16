Return-Path: <linux-scsi+bounces-11543-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2233DA13A7B
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Jan 2025 14:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF9C63A063C
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Jan 2025 13:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD901F37DC;
	Thu, 16 Jan 2025 13:07:25 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779161F37BE
	for <linux-scsi@vger.kernel.org>; Thu, 16 Jan 2025 13:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737032845; cv=none; b=SyBkbESbpGxRLU4xYiFnEs5aB30nYPEDR/8qY233MphnavnvyC5INUph79OobMxZTluURFUy/kTxkHucmBley/fRsoGYBRM4aaBoR4S739IHpYFO4HAjnAw7fcdkd4pCc2SmAjChuiFDCx4lQ+oylmu6bFX60h6+kLeHTE0+Bm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737032845; c=relaxed/simple;
	bh=rmo2fmx8NWHeXe0BSVePybHzO7bTeCJWxm8ZHlUojmk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mjnhnWMz6IsmjswdSpEIii/g5N/btijL7fIUG0+Cx8Fia0FVgCAQOjbawmmxKZtE7pqaS/ZyVF16Na2tPa1ohbW4CNBGhhE9k9yJdxjAmcmo66A4JLygEoOLzX0Oz6ToYmMSJl7XNVGVFCRbzSXWWsC4yVJ1n6dnmApihipXvvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ce7880e816so12664215ab.2
        for <linux-scsi@vger.kernel.org>; Thu, 16 Jan 2025 05:07:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737032841; x=1737637641;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mQi/6bu/3tPBI3ln3zn1h0FyYoqzT3lrOkG2HpG4frc=;
        b=LDyROu25HMKVqywtkjDU2dIaWmYqa++SRRQLDPzo9BVmSnwK+SB9UJknFkzS3Dup7n
         sNbg/i4XwcYULCA+hI63gwxKpYt7iypx2vC4Zq30lmGkdCAQkzlV9sApUfzaIIfbK8We
         kIeDxVUOter5/DcKClf/nBTbg+VI/jkTE6fZT1X5P0xC2T0XnJs4i/v3LLH6ZFI8dxuS
         g71AKIdmgvdAdCjdG/aa7fVWPSawiRlXo+ESA4lNn8SLdaR0E3558HiSG/ktmi/lwY6F
         PEfsznJAcjacIWj1Rf8BIN41mQyrlUuBSV8unWmgcf6Oa/VSe7S0GDnPOjMWj6/J+97O
         un4A==
X-Forwarded-Encrypted: i=1; AJvYcCVVosqkun1aifMLfFNu/mXBGfscLbBUynLgCAY9J56GGM6rsIwu5+JsCk9/N8XP32uO8EFCsmqHvmwS@vger.kernel.org
X-Gm-Message-State: AOJu0YxgW5yw+2k5QA4tf/tHWiptJMfakuv55QcXxBLJgLcCWo01vrag
	BJS+oJ3jkVYVOTLHQt9tcK4wGELpoaJS6Ee9v4gJkcL9CZrhI+6mcOCTyV+WMqOetSRJ4TM7dZH
	JOgXkZFWNHacLlk4Er259BMfPNaqWK09b/WrKtMZfaeGjkb6rYPXTtmQ=
X-Google-Smtp-Source: AGHT+IGsRfXBrJG9XO0C7ARI8I/walJ1UoEVGkR4z6NDug8C+VbF4eL26IKhd10J8f0EdHLpj9X9aT3AG/2Spwx5aTBj2egRF1uH
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3cc9:b0:3ce:9193:20ee with SMTP id
 e9e14a558f8ab-3ce9193242emr33209565ab.17.1737032841335; Thu, 16 Jan 2025
 05:07:21 -0800 (PST)
Date: Thu, 16 Jan 2025 05:07:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67890489.050a0220.20d369.003b.GAE@google.com>
Subject: [syzbot] Monthly scsi report (Jan 2025)
From: syzbot <syzbot+list6f126a98724c339192d0@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello scsi maintainers/developers,

This is a 31-day syzbot report for the scsi subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/scsi

During the period, 1 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 7 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 18      Yes   possible deadlock in sd_remove
                  https://syzkaller.appspot.com/bug?extid=566d48f3784973a22771
<2> 4       Yes   possible deadlock in balance_pgdat (2)
                  https://syzkaller.appspot.com/bug?extid=ac962f01776f0d739973
<3> 1       No    possible deadlock in sg_mmap
                  https://syzkaller.appspot.com/bug?extid=941903927d608a37e1f6

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

