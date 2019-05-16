Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A14612103D
	for <lists+linux-scsi@lfdr.de>; Thu, 16 May 2019 23:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfEPVo5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 16 May 2019 17:44:57 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:35677 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfEPVo4 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 16 May 2019 17:44:56 -0400
Received: by mail-ua1-f66.google.com with SMTP id r7so1906679ual.2
        for <linux-scsi@vger.kernel.org>; Thu, 16 May 2019 14:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=XlxukdrJ2xLU27zBfFGiTZyrc4c/55Xe/PefiZ3j1nE=;
        b=ChAq4alR15hzDP/7jZuI+zdg+RrrOKfWqAztUs2P0fYUjR2oqLfmFelNzNUmqD3SnS
         I/l/bAvxDQw4AIFHeyneUyzLAIsd34fHQPQooTfZzmSYlUzq9v4EgZ3d3fcscjUGFYmZ
         Vnti7Ulk2qiatrYcNfzZ8XrjzfsJnzVI545SpNq5lU39aRz8tjM4b8DjFG2gjJ6lx0B6
         b+S5wk3fkBuweL/fGCKUbA90py0dgJL92R7TXrG4sOj4JjfVMIAUiEXm/2A6EvWjZXAK
         O4O02NxKmWU4ynCpt6RokqBtmZyxVvIxpf1xCFU8xuYjTa3/CP8kpgmPO4Oek7w5mWHf
         Bzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=XlxukdrJ2xLU27zBfFGiTZyrc4c/55Xe/PefiZ3j1nE=;
        b=LzsHliaKb05v+vgIoEckyQ/Xelb9LLE2DKzgjfS/puqD9KAcrHYLq/VAVhQmrJvcuK
         LjkknzlbIOqqnoXKNyBYClgltznIsqzI8VX/IiygzgX50rDgzGZETlIuNcD8O+D7/u1L
         CPaaoBX+NSA2G6KYoFY1f6SfVKmH4CU1hV4cNnFL9qsUyo3bPgPT7YSf/feA9+CtwYOU
         MHIgrOav7FKs9BAH7KGXUegp2AteqvYfJJ4WVm7dmHEuWBrA0wGHO80GarrgPW0XmEyX
         IkZKA/AQrLKDMSabUd8GiZ8Sfbp5rHf/LmjufieE/ZgvQaOVMFCpAysCc+rCKTbtRJxh
         dtfw==
X-Gm-Message-State: APjAAAUXtuVi3iSNAFOwd15M1VIALmrQu9MOmsKOJOdWNKNRFb5UJzNs
        HzPhghmw9PqHyLNoNJR3h54yl4quxbRxUh1XVQ==
X-Google-Smtp-Source: APXvYqwTSzTnr3yuOFlF6OWYsVdYFRbQ93anLYlmf3PRDybNYE+Xo3XlOqr8G+Y2kdVEvXD1MU8g0sceZqvEdWqWZB4=
X-Received: by 2002:ab0:7609:: with SMTP id o9mr21286084uap.54.1558043095775;
 Thu, 16 May 2019 14:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8WD_be_3=iHDpMYL+fKEFW6BbG8s=0TUPVm4ojiS7orOr0zA@mail.gmail.com>
 <20190513070218.GA25920@infradead.org> <CAP8WD_ZuOHn2VWjgYr-rLBd7Lm33nTvCvu7WKqW_0gfzqbbCLQ@mail.gmail.com>
 <20190513122846.GA15835@infradead.org> <CAP8WD_YTqcduLsYRU-tCsCLC9wvAp4624Ls350Eb98K_fs0+Hw@mail.gmail.com>
 <20190516065823.GA17189@infradead.org>
In-Reply-To: <20190516065823.GA17189@infradead.org>
Reply-To: whiteheadm@acm.org
From:   tedheadster <tedheadster@gmail.com>
Date:   Thu, 16 May 2019 17:44:43 -0400
Message-ID: <CAP8WD_Z11rikDsn-8u12RYgaXrkReuDyvHLBfsDhCES4EpatTQ@mail.gmail.com>
Subject: Re: Poor SWIOTLB Performance with HIGHMEM64G
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Whitehead <whiteheadm@acm.org>, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, May 16, 2019 at 2:58 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> Can you still send me the dmesg output with the AHCI debug patch?
> I'm curious why we can't do 64-bit DMA to your device.

Christoph,
  here is the dmesg output with your patch. 64-bit mode is not enabled.

ahci 0000:00:11.4: version 3.0
ahci 0000:00:11.4: failed to set 64-bit mask!
ahci 0000:00:11.4: AHCI 0001.0300 32 slots 4 ports 6 Gbps 0x1 impl SATA mode
ahci 0000:00:11.4: flags: 64bit ncq pm led clo pio slum part ems apst
scsi host0: ahci
scsi host1: ahci
scsi host2: ahci
scsi host3: ahci
ata1: SATA max UDMA/133 abar m2048@0xf733d000 port 0xf733d100 irq 26
ata2: DUMMY
ata3: DUMMY
ata4: DUMMY
ahci 0000:00:1f.2: failed to set 64-bit mask!
ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 4 ports 6 Gbps 0x3 impl RAID mode
ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part ems apst
scsi host4: ahci
scsi host5: ahci
scsi host6: ahci
scsi host7: ahci
ata5: SATA max UDMA/133 abar m2048@0xf7336000 port 0xf7336100 irq 27
ata6: SATA max UDMA/133 abar m2048@0xf7336000 port 0xf7336180 irq 27
ata7: DUMMY
ata8: DUMMY

Remember: this is running a 32-bit kernel on 64-bit hardware (Sandy
Beach E5-2630). The IOMMU was successfully enabled too.

DMAR: IOMMU enabled
pci 0000:ff:0b.0: Adding to iommu group 0
pci 0000:ff:0b.1: Adding to iommu group 0

- Matthew
