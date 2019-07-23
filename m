Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D52571164
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jul 2019 07:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732295AbfGWFtb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 23 Jul 2019 01:49:31 -0400
Received: from verein.lst.de ([213.95.11.211]:38624 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727398AbfGWFtb (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 23 Jul 2019 01:49:31 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 254CA68B20; Tue, 23 Jul 2019 07:49:30 +0200 (CEST)
Date:   Tue, 23 Jul 2019 07:49:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, martin.petersen@oracle.com,
        tom.leiming@gmail.com, dexuan.linux@gmail.com,
        Damien.LeMoal@wdc.com, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: fix the dma_max_mapping_size call
Message-ID: <20190723054929.GB17148@lst.de>
References: <20190722092038.17659-1-hch@lst.de> <38dd48c2-12fe-8521-4beb-7b4c415cc710@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38dd48c2-12fe-8521-4beb-7b4c415cc710@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Jul 22, 2019 at 12:37:44PM -0700, Bart Van Assche wrote:
> Is it possible that a device defines a maximum mapping size but no DMA 
> mask? Is the NULL pointer dereference that can happen an attempt to 
> dereference dev->dma_ops? Have you considered to test the get_dma_ops() 
> return value instead of dev->dma_mask? I think that would make this code 
> easier to read.

The dma max mapping size needs dma support an thus a dma mask, as we've
phased out support for a NULL dma_mask for dma supporting devices.
