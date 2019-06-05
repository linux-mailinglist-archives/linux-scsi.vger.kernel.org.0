Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7923643A
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Jun 2019 21:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfFETKY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 5 Jun 2019 15:10:24 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44786 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfFETKX (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 5 Jun 2019 15:10:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id n2so12912325pgp.11
        for <linux-scsi@vger.kernel.org>; Wed, 05 Jun 2019 12:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ECON+3GqS4gPhtd0pv7FErM7REhB/G/cWUwMq48vsuw=;
        b=jish6J8M/xP0Fp6UOlEa+Ly3bbYcg/Q/GGmqjPbTE+LnbRn8KO2KjMTEQGktrU3Y2m
         fHXFGMy6x4fkSawSJKjjvqoZ4AMdUoWZboAeeGPuer2ukfjUSSvaWsUQf7fRk0KEhH8E
         L2gaedIJ8fDffWKAqLQgeD9/l2I2RJJRCOAbDM2Ro58QwOWXASbCn6PlyFDzsBahC6kA
         mRU7YkayEy+tqNIIi+J5osjuxSI6l5pFy9yH7/2goJkrnjWmW4fMCfmFdL7eqgNqFpiw
         OVKD61ZBQoQE6+qDtOO1GrUZ+/uPugM920SFXc/t1/fn/DmWBVVTUKlMuRt4etA1PR7U
         AiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ECON+3GqS4gPhtd0pv7FErM7REhB/G/cWUwMq48vsuw=;
        b=VBphs6lcmWkkctXH+Uk91LazCi3w2sPRUhwmmYQDCmDKbvCyatXNaqTqqFAiT3U5k1
         Yk0Ka/Fqsp7DUUpJ6Hh1ychqjZVtvW3sVUO8f7h4nD/sKJ7pl+bejcJKxR61lLgHJs4Y
         Tbsj1upD5KfIa/MF9bDEELxHT21bjjxJlCW14cRD+iCOG1/eybmjAdEPQkee5s0vns7F
         zADyzGqYvyzP8jWyO6Z5VyKDh2qABhc2NI5clFK0uZm5EtYMsI6wizElpZhJmcGY9gw/
         TjRVRq1CoBQL6tSf9aLMwhIe3bgDEP2txFsayZD4lcCaju6DTY3NDCElW7cU2D8gFY7Q
         WG6w==
X-Gm-Message-State: APjAAAVNhu4LfXZSUnierkXb4Ae3LXlqBXDQ/qK6Jh4uz6prDC+wpm6p
        3CH7a2fF5dfQu9Cx3gblgLJRGw==
X-Google-Smtp-Source: APXvYqye5sLFtUV5ShpAXZlEr0EuAV0uNSE4iugyD42OUt69HRIWpRIXqGtLvlM3f2RxFe5+Aa1FUA==
X-Received: by 2002:a63:5b5c:: with SMTP id l28mr365033pgm.158.1559761822336;
        Wed, 05 Jun 2019 12:10:22 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id x1sm18065098pgq.13.2019.06.05.12.10.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 05 Jun 2019 12:10:22 -0700 (PDT)
Date:   Wed, 5 Jun 2019 12:10:20 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH] revert async probing of VMBus scsi device
Message-ID: <20190605121020.1a41b753@hermes.lan>
In-Reply-To: <20190605190722.GA19684@infradead.org>
References: <20190605185205.12583-1-sthemmin@microsoft.com>
        <20190605185637.GA31439@infradead.org>
        <20190605120640.00358689@hermes.lan>
        <20190605190722.GA19684@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, 5 Jun 2019 12:07:23 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Jun 05, 2019 at 12:06:40PM -0700, Stephen Hemminger wrote:
> > > Which is true for every device, and why we use UUIDs or label for
> > > mounts that are supposed to be stable.  
> > 
> > Not everyone is smart enough to do that.  
> 
> Sure.  But they should not get a way out for just one specific driver.

There are people running new kernels on 6 year old distributions.
Was every distribution smart enough then? If you think so, then
this not necessary.
