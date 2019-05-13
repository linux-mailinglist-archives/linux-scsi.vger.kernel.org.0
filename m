Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8A8F1B0AE
	for <lists+linux-scsi@lfdr.de>; Mon, 13 May 2019 09:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfEMHCV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 13 May 2019 03:02:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44944 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfEMHCT (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 13 May 2019 03:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DA+Sm5vgRv72otHEU0C2u5YNWIZobZxPRSDghkDeLNU=; b=UwRu+Xb22w9QIyQMpNeFGQO46
        WWmiwD6PGwjeI4xzZIhXovI/eJIqSPPMQZzsJ6NSk3yNcEJu97YnpMhXQkDsXAw8ejqa5vWWsIbDP
        MhMnhPGFYbl4UwwJUnO7j3csYMoLd99iMBkPKNn3mXMLoWtaLw6sYhxptDTSFb5kR+ep8UqtdY1Km
        J3aaTEENejUIeOYQxGyACJTBFsqcyFNq0cV25HVw2qVCjfM8LIOLmMYnED7sKhkI4IqUF6tbD1QEh
        I+oIMswDqDnWEiOcQVbNPHBMuVn5jiL43XC97mV7gGI+jM3kFtZX053Ct2BrotJuQyCSZ8W8DjKzT
        5RJNJZQTg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQ4yZ-0007T2-3P; Mon, 13 May 2019 07:02:19 +0000
Date:   Mon, 13 May 2019 00:02:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     whiteheadm@acm.org
Cc:     Christoph Hellwig <hch@infradead.org>, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
Subject: Re: Poor SWIOTLB Performance with HIGHMEM64G
Message-ID: <20190513070218.GA25920@infradead.org>
References: <CAP8WD_be_3=iHDpMYL+fKEFW6BbG8s=0TUPVm4ojiS7orOr0zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8WD_be_3=iHDpMYL+fKEFW6BbG8s=0TUPVm4ojiS7orOr0zA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sun, May 12, 2019 at 02:55:48PM -0400, tedheadster wrote:
> Christoph,
>   On the same hardware (reboot with different kernel) I am getting
> _horrible_ disk I/O performance on the 5.1.1. kernel compiled on a
> 32-bit platform using HIGHMEM64G (PAE) to access 32GiB of physical
> memory.
> 
> The numbers are truly terrible to copy a 16GiB file from one disk to a
> different one:

This sounds like your storage controller only supports 32-bit DMA.
In that case any memory above that will be bounce buffered, that
is copied from one piece of memory to another, which in addition
to the copying will also create memory pressure.

What storage controller do you use?  Also if the CPU is 64-bit
capable you really should use a 64-bit kernel with 32-bit userspace
for a setup like that, as the VM folks do not spend any effort on
optimizing large highmem setups.
