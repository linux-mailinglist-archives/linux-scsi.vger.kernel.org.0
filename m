Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E02A3612C
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Jun 2019 18:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbfFEQZk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 5 Jun 2019 12:25:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33899 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfFEQZk (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 5 Jun 2019 12:25:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id h2so9427061pgg.1
        for <linux-scsi@vger.kernel.org>; Wed, 05 Jun 2019 09:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2I33XKmaQqwFezXo9p3qtqWleV96bD7nXAO9VM8y09I=;
        b=n9tRDmy0k7J42b2PhFQJzQiKCEU0pgOCVRs5k0LCPeKJ5Wa0+Ogs875FLKzF1qlXBF
         z0Blm8zsSXPo/lmjGf5DktePxtLG8L3yn7O8yCeVUDYwVRLgkV+7g4lNdMPsPe4gXHaa
         kx+KvJV5xJ5McyQ7jtIZhJwzClCHmRj2DsibXpwyfcGV0wyNUZQW9ckJDOLCDeMNJmKw
         IzGZCmsar3Ces28KmvrNSNLJL1dgaDQ7VrbzPtHQsNYeZY4LlZCqwLepCyDYx7Zfm3Dm
         OgcjbYZ/A78/Bio3/nPuGpykk93/bZCmJPKbBwGSrtxynHCz9TKRj0hk0Xy3Ofw4Oh0e
         bXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2I33XKmaQqwFezXo9p3qtqWleV96bD7nXAO9VM8y09I=;
        b=TIeuUclBqP8wq9zNEMAfcpQwIG6r4PGGnq+r64pGrz8oJz0aLSV1QGlxOjxM+kLumY
         lPOzPzAf0tG1v2fDCbS7BIeEZ7hae1pYtvf6F1PxwuQf+Svs7IgHmWIBK/AMr2N3/u1J
         e567rOVuEeYHQQnlGVpEhs/21GYwiewNmnDnVJN3G4iSj68xesmCnnDbPcFT0wr6kHj7
         jDY/W8jMkwXZItTDg7ejFbKnrYtz6U19qUyDWxTaYYRlL9vgbrJjjeC3pEkQQed6uOMv
         2131Wu009jglPSSK+sQqB7T5sr5f+rOiCzRmdUwqn0HdOoPnUkwk8DLXrI8EY9xnG36O
         tRsA==
X-Gm-Message-State: APjAAAWKyo7sxcdjSGmTHFw56x3BfjmB1l2M3iLLkr3t1AJgWjiwW0uv
        iAhj7j10yMiFvMuJI5CPvwA=
X-Google-Smtp-Source: APXvYqxkzxKM1ZDEEp6bZco5yt/Img63RfAP+IPt/ZJMJKtZjGEoPiH+vNyMPEYdqnSYoFenpbUBAw==
X-Received: by 2002:a17:90a:8c82:: with SMTP id b2mr44597807pjo.97.1559751939663;
        Wed, 05 Jun 2019 09:25:39 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z125sm25468454pfb.75.2019.06.05.09.25.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 09:25:38 -0700 (PDT)
Date:   Wed, 5 Jun 2019 09:25:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Finn Thain <fthain@telegraphics.com.au>
Subject: Re: [PATCH V2 0/3] scsi: three SG_CHAIN related fixes
Message-ID: <20190605162537.GA32657@roeck-us.net>
References: <20190605010623.12325-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605010623.12325-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Jun 05, 2019 at 09:06:20AM +0800, Ming Lei wrote:
> Hi,
> 
> Guenter reported scsi boot issue caused by commit c3288dd8c232
> ("scsi: core: avoid pre-allocating big SGL for data").
> 
> Turns out there are at least three issues.
> 
> The 1st patch fixes sg_alloc_table_chained() which may try to use
> the pre-allocation SGL even though user passes zero to 'nents_first_chunk'.
> 
> The 2nd patch fixes issue in case that NO_SG_CHAIN on some ARCHs,
> such as alpha, arm and parisc.
> 
> The 3rd patch makes esp scsi working with SG_CHAIN.
> 
> V2:
> 	- add the patch1, which is verified by Guenter
> 	- add .prv_sg to store the previous sg for esp_scsi
> 
> Ming Lei (3):
>   scsi: lib/sg_pool.c: clear 'first_chunk' in case of no pre-allocation
>   scsi: core: don't pre-allocate small SGL in case of NO_SG_CHAIN
>   scsi: esp: make it working on SG_CHAIN
> 

Running my tests on next-20190605, I get:

Qemu test results:
	total: 349 pass: 296 fail: 53

The same tests on next-20190605 plus this series results in:

Qemu test results:
	total: 349 pass: 347 fail: 2
Failed tests: 
	sh:rts7751r2dplus_defconfig:usb:rootfs
	sh:rts7751r2dplus_defconfig:usb-hub:rootfs

The remaining failures are consistent across re-runs. The failure is only
seen when booting from usb using the sm501-usb controller (see below).

usb 1-2.1: reset full-speed USB device number 4 using sm501-usb
sd 1:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x03 driverbyte=0x00
sd 1:0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 00 08 7c 00 00 f0 00
print_req_error: I/O error, dev sda, sector 2172 flags 80700
usb 1-2.1: reset full-speed USB device number 4 using sm501-usb
sd 1:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x03 driverbyte=0x00
sd 1:0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 00 01 da 00 00 f0 00
print_req_error: I/O error, dev sda, sector 474 flags 84700
usb 1-2.1: reset full-speed USB device number 4 using sm501-usb
sd 1:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x03 driverbyte=0x00
sd 1:0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 00 02 da 00 00 f0 00
print_req_error: I/O error, dev sda, sector 730 flags 84700
usb 1-2.1: reset full-speed USB device number 4 using sm501-usb
sd 1:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x03 driverbyte=0x00
sd 1:0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 00 0b 50 00 00 f0 00
print_req_error: I/O error, dev sda, sector 2896 flags 84700

Presumably that means that either the sm501-usb emulation has a subtle bug
associated with SG, or something is wrong with the sm501-usb driver.

The qemu command line in the failure case is:

qemu-system-sh4 -M r2d \
	-kernel ./arch/sh/boot/zImage \
	-snapshot \
	-usb -device usb-storage,drive=d0 \
	-drive file=rootfs.ext2,if=none,id=d0,format=raw \
	-append 'panic=-1 slub_debug=FZPUA root=/dev/sda rootwait console=ttySC1,115200 earlycon=scif,mmio16,0xffe80000 noiotrap' \
	-serial null -serial stdio \
	-net nic,model=rtl8139 -net user -nographic -monitor null

I'll be happy to provide kernel configuration and a pointer to the root file
system if needed.

Thanks,
Guenter
