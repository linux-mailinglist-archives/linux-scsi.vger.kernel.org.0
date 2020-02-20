Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D983B16648B
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Feb 2020 18:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgBTRZa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Feb 2020 12:25:30 -0500
Received: from verein.lst.de ([213.95.11.211]:50640 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727868AbgBTRZ3 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 20 Feb 2020 12:25:29 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C28BE68BFE; Thu, 20 Feb 2020 18:25:27 +0100 (CET)
Date:   Thu, 20 Feb 2020 18:25:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: Re: [PATCH 2/2] ufshcd: use an enum for quirks
Message-ID: <20200220172527.GC14530@lst.de>
References: <20200218234450.69412-1-hch@lst.de> <20200218234450.69412-3-hch@lst.de> <b4c75415-347a-48e6-ddc7-d419d7774f22@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4c75415-347a-48e6-ddc7-d419d7774f22@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Feb 18, 2020 at 04:10:57PM -0800, Bart Van Assche wrote:
> On 2/18/20 3:44 PM, Christoph Hellwig wrote:
>> Use an enum to specify the various quirks instead of #defines inside
>> the structure definition.
>
> Hi Christoph,
>
> Although this patch looks like a significant improvement to me: has it been 
> considered to change 'quirks' from an unsigned int into a bitfield with one 
> bit per quirk? I think that would allow to remove multiple explicit bit 
> manipulations from the UFS driver.

And it wouldn't make it quite as obvious what are quirks.  Never mind that
the compiler would still do the masking and potentially affect other fields
placed right next to it.  Bitfields tend to be a bad idea just about
everywhere.
