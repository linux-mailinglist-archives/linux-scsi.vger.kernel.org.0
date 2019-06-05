Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01767366C0
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Jun 2019 23:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfFEVWq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 5 Jun 2019 17:22:46 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35122 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFEVWq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 5 Jun 2019 17:22:46 -0400
Received: by mail-pf1-f194.google.com with SMTP id d126so98644pfd.2
        for <linux-scsi@vger.kernel.org>; Wed, 05 Jun 2019 14:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+pBD1nzAei0AOxcZ7Ad2nlIElXKEjyzkqCcfuUKmJCE=;
        b=WCRvqvaUuc4FP3VLeuxXeAUG7kwfIdiwh8unOhudfCGXXfx6qZ2otEtKmEu0RCQoBo
         0E9719JeJhLUhqCxK4ZYGx/EQRgoEkelKWukWCdLVf6BBOGuYPtpX6c7pOhVxZ3N+O/R
         eKZSDyjqXjAnpjCdw2/yIR6e7e7CPnBYds5KSE+s9tQCWvf+jGj2MG3aYtdKDf//bZgk
         7mnG7d9IlVF03NI1owVixJQtiTEybXuV5wFbAysqzpqUx2v+MGAd3p7WC4ysNfqfbjU6
         39DIw0VCDR5fSM3abfsabBIUolBImjovQjkLqz7aNT/U0LiWyhW5t/rfssB78ow9EMfi
         1Icg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+pBD1nzAei0AOxcZ7Ad2nlIElXKEjyzkqCcfuUKmJCE=;
        b=PZn+NSglislunSbRAl2Oqv9adL/iSmlZ5WFbSvRTadiF/GanDHJpWE7exi+hZceGow
         GK5gLy6j4kjQDXKxIjuNrj72IWE/NEJb747fgmdUsEM0kPFByHyO60tWng4ik7WBLCEA
         9Hu4rNG6SC8QWT6p2RTyZp3a/eZwDwodbh2jlGxjlcMg72Q5tGLewy7RGC3Z9Y47nLOp
         qD+fMMYrlm2jfTyBmINSfF4YtjzdUJYpu0+en46pki80aQ6VB0WQq008jxljGfVPzGCC
         yR0TVfDox7SKFRg+Wi0EvdsMow3qAAet+f6+ZX4Gzhkhk9ePlBgCn3MKZXCzNaE2iIBi
         Dd6A==
X-Gm-Message-State: APjAAAXoXpcpWbXES4mzFAcnfruEInFXYxZew9PgHrxJxKl9ssxAkm8a
        g4f+tKixrCb7IoE5smlJFz8=
X-Google-Smtp-Source: APXvYqyH7l4KeZU7zA61/i0O23mKd0Kt7BAnvwy3GPjOipP2kh9ydJDTLrZ0SV817sziWoRb50QHFw==
X-Received: by 2002:a65:64d9:: with SMTP id t25mr1129974pgv.130.1559769765026;
        Wed, 05 Jun 2019 14:22:45 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k22sm12314446pfa.87.2019.06.05.14.22.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 14:22:44 -0700 (PDT)
Date:   Wed, 5 Jun 2019 14:22:43 -0700
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
Message-ID: <20190605212243.GA28525@roeck-us.net>
References: <20190605010623.12325-1-ming.lei@redhat.com>
 <20190605162537.GA32657@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605162537.GA32657@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Jun 05, 2019 at 09:25:37AM -0700, Guenter Roeck wrote:
> On Wed, Jun 05, 2019 at 09:06:20AM +0800, Ming Lei wrote:
> > Hi,
> > 
> > Guenter reported scsi boot issue caused by commit c3288dd8c232
> > ("scsi: core: avoid pre-allocating big SGL for data").
> > 
> > Turns out there are at least three issues.
> > 
> > The 1st patch fixes sg_alloc_table_chained() which may try to use
> > the pre-allocation SGL even though user passes zero to 'nents_first_chunk'.
> > 
> > The 2nd patch fixes issue in case that NO_SG_CHAIN on some ARCHs,
> > such as alpha, arm and parisc.
> > 
> > The 3rd patch makes esp scsi working with SG_CHAIN.
> > 
> > V2:
> > 	- add the patch1, which is verified by Guenter
> > 	- add .prv_sg to store the previous sg for esp_scsi
> > 
> > Ming Lei (3):
> >   scsi: lib/sg_pool.c: clear 'first_chunk' in case of no pre-allocation
> >   scsi: core: don't pre-allocate small SGL in case of NO_SG_CHAIN
> >   scsi: esp: make it working on SG_CHAIN
> > 
> 
> Running my tests on next-20190605, I get:
> 
> Qemu test results:
> 	total: 349 pass: 296 fail: 53
> 
> The same tests on next-20190605 plus this series results in:
> 
> Qemu test results:
> 	total: 349 pass: 347 fail: 2
> Failed tests: 
> 	sh:rts7751r2dplus_defconfig:usb:rootfs
> 	sh:rts7751r2dplus_defconfig:usb-hub:rootfs
> 
> The remaining failures are consistent across re-runs. The failure is only
> seen when booting from usb using the sm501-usb controller (see below).
> 
> usb 1-2.1: reset full-speed USB device number 4 using sm501-usb
> sd 1:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x03 driverbyte=0x00
> sd 1:0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 00 08 7c 00 00 f0 00
> print_req_error: I/O error, dev sda, sector 2172 flags 80700
> usb 1-2.1: reset full-speed USB device number 4 using sm501-usb
> sd 1:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x03 driverbyte=0x00
> sd 1:0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 00 01 da 00 00 f0 00
> print_req_error: I/O error, dev sda, sector 474 flags 84700
> usb 1-2.1: reset full-speed USB device number 4 using sm501-usb
> sd 1:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x03 driverbyte=0x00
> sd 1:0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 00 02 da 00 00 f0 00
> print_req_error: I/O error, dev sda, sector 730 flags 84700
> usb 1-2.1: reset full-speed USB device number 4 using sm501-usb
> sd 1:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x03 driverbyte=0x00
> sd 1:0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 00 0b 50 00 00 f0 00
> print_req_error: I/O error, dev sda, sector 2896 flags 84700
> 
> Presumably that means that either the sm501-usb emulation has a subtle bug
> associated with SG, or something is wrong with the sm501-usb driver.
> 

Turns out the above is caused by other (unrelated) patches in the sm501
USB driver. After reverting those, everything is fine. Sorry for the noise.
Please feel free to add

Tested-by: Guenter Roeck <linux@roeck-us.net>

to all three patches.

Thanks,
Guenter

> The qemu command line in the failure case is:
> 
> qemu-system-sh4 -M r2d \
> 	-kernel ./arch/sh/boot/zImage \
> 	-snapshot \
> 	-usb -device usb-storage,drive=d0 \
> 	-drive file=rootfs.ext2,if=none,id=d0,format=raw \
> 	-append 'panic=-1 slub_debug=FZPUA root=/dev/sda rootwait console=ttySC1,115200 earlycon=scif,mmio16,0xffe80000 noiotrap' \
> 	-serial null -serial stdio \
> 	-net nic,model=rtl8139 -net user -nographic -monitor null
> 
> I'll be happy to provide kernel configuration and a pointer to the root file
> system if needed.
> 
> Thanks,
> Guenter
