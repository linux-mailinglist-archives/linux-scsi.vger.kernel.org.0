Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B206F1D37DF
	for <lists+linux-scsi@lfdr.de>; Thu, 14 May 2020 19:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgENRUL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 14 May 2020 13:20:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbgENRUL (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 14 May 2020 13:20:11 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D96020675;
        Thu, 14 May 2020 17:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589476811;
        bh=1Slh1jAIQasC7oy5STlzKdwDEasGK+1ViVF0dYn2UmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CpJw5z3k6WBUHnPll2p/7cPcDlnmtqiIB4XkKMzp0OqH5Sg/QsOJ+x0Bapi9QuvCE
         QMz49/Vaf7hVCNR8nSKa2ixJGm4EiyAj46AY9TjVEOmCVpK7llIc5IlLsPAizZeBfd
         2B48xbwwRYkdb0DbRrlAmUH/iegViFj6OhYoDbpg=
Date:   Fri, 15 May 2020 02:20:04 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Tony Asleson <tasleson@redhat.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [RFC PATCH v2 7/7] nvme: Add durable name for dev_printk
Message-ID: <20200514172004.GA3513@redsun51.ssa.fujisawa.hgst.com>
References: <20200513213621.470411-1-tasleson@redhat.com>
 <20200513213621.470411-8-tasleson@redhat.com>
 <20200513230455.GA1503@redsun51.ssa.fujisawa.hgst.com>
 <5e2dc4ab-c97d-030d-7640-9b2c52ccc91e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e2dc4ab-c97d-030d-7640-9b2c52ccc91e@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, May 14, 2020 at 12:13:36PM -0500, Tony Asleson wrote:
> On 5/13/20 6:04 PM, Keith Busch wrote:
> > On Wed, May 13, 2020 at 04:36:21PM -0500, Tony Asleson wrote:
> >> +static int dev_to_nvme_durable_name(const struct device *dev, char *buf, size_t len)
> >> +{
> >> +	char serial[128];
> >> +	ssize_t serial_len = wwid_show((struct device *)dev, NULL, serial);
> > 
> > wwid_show() can generate a serial larger than 128 bytes.
> 
> Looking at this again
> 
> return sprintf(buf, "nvme.%04x-%*phN-%*phN-%08x\n", 	
>     subsys->vendor_id,
>     serial_len, subsys->serial,
>     model_len, subsys->model,
>     subsys->ns_id);
> 
> 'nvme.' = 5
> vendor_id = 4
> '-' = 1
> serial (20 * 2) = 40
> '-' = 1
> model (40 * 2) = 80
> '-' = 1
> ns_id = 8
> '\n' = 1
> 
> 5 + 4 + 1 + 40 + 1 + 80 + 1 + 8 + 1 = 141
> 
> Does this match your understanding?

Yep, that looks like the correct max possible length. I didn't actually
count it out, but I just knew it could be larger than 128. :)
