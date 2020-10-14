Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CEF28D7AC
	for <lists+linux-scsi@lfdr.de>; Wed, 14 Oct 2020 02:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgJNApK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 13 Oct 2020 20:45:10 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:57201 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbgJNApK (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 13 Oct 2020 20:45:10 -0400
Received: by mail-io1-f69.google.com with SMTP id y19so1232830iow.23
        for <linux-scsi@vger.kernel.org>; Tue, 13 Oct 2020 17:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ZlnVN06zvE5cF9KZreYd2wyFcOusb7soW5MmKwdjdcA=;
        b=jhhpbQa7ZzqDkd+6aNMWt+N/y90A7+3mKgVQ/lai/FWJUs2VxcSKOUoPW1zSMdbMTF
         8CeYBbuxfDifZJku154kVSRJ9XHXPsLwtXEJoP6UgyqjlXef15CLhOnF/IxDP7J/K8Jo
         Ibaw9hj7MwatwmKYKRqVx54ioK0zlFGcLCaMS6ncdHTW4dvJ1hVFhWhDqEDszXmKS6Eg
         rvkh42HveAjqiD619bR1PN9JSq1Wwjg3gZrGOnLKl+RwjTxVqMYNYxTLaSH0MCBWTXzb
         Ohasd1m200IMX23XIAWYwNcDvTWroHPKb/aJrh2cjmIZt6XYR/cnaMjlWYWzhi7ZsQgu
         SywQ==
X-Gm-Message-State: AOAM530Eca4JqfgzqZ0yPlhvHnEr/gknHOd1JgmD4Ro2UbDj5JqZmWFD
        v1HSrVbjUHVp8zpfZ1VrvliJDOWiZa1YlftcwOnAWtyFzI8A
X-Google-Smtp-Source: ABdhPJw4swHS/dpCZd6s1X5CU9CnyB+o5kjhxjq8HfcnLo08QTJaf/V+oern5AJ6ynrqdkK+8s7xs48l3i8GD2dpaoOc0eDeWe6U
MIME-Version: 1.0
X-Received: by 2002:a92:c946:: with SMTP id i6mr1954470ilq.199.1602636309649;
 Tue, 13 Oct 2020 17:45:09 -0700 (PDT)
Date:   Tue, 13 Oct 2020 17:45:09 -0700
In-Reply-To: <95f493a39c2a6cc2f45da2f7fe73d7febee927df.camel@linux.ibm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f0df8b05b196d7d5@google.com>
Subject: Re: general protection fault in scsi_queue_rq
From:   syzbot <syzbot+0796b72dc61f223d8cc5@syzkaller.appspotmail.com>
To:     hare@suse.de, hch@lst.de, jejb@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+0796b72dc61f223d8cc5@syzkaller.appspotmail.com

Tested on:

commit:         69f4ec1e scsi: hisi_sas: Recover PHY state according to th..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc
kernel config:  https://syzkaller.appspot.com/x/.config?x=caba25cc405f3c66
dashboard link: https://syzkaller.appspot.com/bug?extid=0796b72dc61f223d8cc5
compiler:       gcc (GCC) 10.1.0-syz 20200507

Note: testing is done by a robot and is best-effort only.
