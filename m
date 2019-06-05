Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 499D2366AD
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Jun 2019 23:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfFEVU1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 5 Jun 2019 17:20:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43321 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfFEVU1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 5 Jun 2019 17:20:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so71118pfg.10
        for <linux-scsi@vger.kernel.org>; Wed, 05 Jun 2019 14:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cbSNX6Rtq6xgkNTyw8B4sm3beoNnOfKEeukM3sDO+IE=;
        b=bA0CKpMOuTL8Y8LhFO/IeHVomPpIS8AtGZw3EP/UDhOLHCT/8aDT3fs30kyHtqBpHx
         6q8RHl1CbJnYXGjyC/3UhR0rChzmdqcegMm7RkY2yrnY4O1DEVqzkwfCZ5bdd0yVNdnA
         sAfhSsM+gSI6ILdxaSkY3DlIn/CSvNZB/q/Ew08XgSxJCoGytGqJexKnbRo79LvQ022N
         OtG+79ytL842FSuiDZswVfMViNrT5Uf2p4d3mFUCkTdRXGInen4v12eUUtrsao4UZ3f5
         6QkPwLkzG7yJyYVDQjqNJ0fWc2TONnB00scR1otaIMCfmdcgsGWg4tAYgYStHdzYZ2x+
         Rl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cbSNX6Rtq6xgkNTyw8B4sm3beoNnOfKEeukM3sDO+IE=;
        b=FOKuq+MVJlsxdPWkSD3z0DWb7XgK7mUCqCwZGMz1kAAy38862MM7RwdKTKWAtQfC5H
         A8+z6YtsF7OQvDYs2CdbttemqH8owKJVyN9GM8ozgPv3pVFln4TkLEG2EmqXGglJ6uEj
         ReVjm3TpxW5Y4Dc1YCjxdqYBBGAQ5onxl1Qx+FNN/oj4fpZUPI8zurHMYB9TeRx0lexv
         vZTk0/jzA5BFU6IoIST3TE7ZVhj0MdU4NoMqfZXzMgp2NAZ34M5o3uVEfzfW2VmnQT/N
         /Dji9k6Az3OhYlVCeslT0Irpkv6z4uAOgSeePn4rJXjiD7NKsenzd61b12nVatBRy6L3
         Srbg==
X-Gm-Message-State: APjAAAWxV6OVS9Bg7gXUy1XlgbDzbW2U6Ff8TuC/eQeTWmWdi5YtSac6
        vvri2au8PNSXKName2MxaHZQsw==
X-Google-Smtp-Source: APXvYqyZitJoRGelzSbSpcT25jvfTuWBHAaXphn8TImPNCrJZYSK6JjkbR81/MF9LsMtiDsNLhMUTA==
X-Received: by 2002:a17:90a:650c:: with SMTP id i12mr47893479pjj.44.1559769626247;
        Wed, 05 Jun 2019 14:20:26 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id d24sm4340pjv.24.2019.06.05.14.20.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 05 Jun 2019 14:20:26 -0700 (PDT)
Date:   Wed, 5 Jun 2019 14:20:24 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH] revert async probing of VMBus scsi device
Message-ID: <20190605142024.1589a7b4@hermes.lan>
In-Reply-To: <20190605192647.GA25034@infradead.org>
References: <20190605185205.12583-1-sthemmin@microsoft.com>
        <20190605185637.GA31439@infradead.org>
        <20190605120640.00358689@hermes.lan>
        <20190605190722.GA19684@infradead.org>
        <20190605121020.1a41b753@hermes.lan>
        <20190605192647.GA25034@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, 5 Jun 2019 12:26:47 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Jun 05, 2019 at 12:10:20PM -0700, Stephen Hemminger wrote:
> > > Sure.  But they should not get a way out for just one specific driver.  
> > 
> > There are people running new kernels on 6 year old distributions.
> > Was every distribution smart enough then? If you think so, then
> > this not necessary.  
> 
> I think you are missing my point.  If we want a way to disable this,
> we:
> 
>  a) want it opt-in
>  b) it needs to for the whole SCSI layer and not just one driver

Based on feedback from the Program Manager who handles the distros
the patch for storvsc is not needed.

SCSI device naming was never deterministic anyway.  
Cloud-init relies on the same mechanism as the Azure agent to detect the OS and ephemeral disk. 
