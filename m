Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF46C363C1
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Jun 2019 21:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfFETGm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 5 Jun 2019 15:06:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41520 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfFETGm (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 5 Jun 2019 15:06:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id q17so15390818pfq.8
        for <linux-scsi@vger.kernel.org>; Wed, 05 Jun 2019 12:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Vx/AV9moqrhgu7Ph+ldHwoba6eE+vsY0eVf5PphJ6Q=;
        b=yEzqtrTHmwZC14RWz8x/UiqwPUR4E+4tGp7mIPm5QmEJ3HlJcxmNzYA0htdcpS43L8
         Mo2M2k23Cure6IGBdn+xEo5+u8BbOZCdCfuKldZSdHCdc3AbmQ9ncE/vnQwj+HqVGTRy
         kqsakZWdD4/kF82UvVDEztEYDdPt/+hySZMOWOJRlM954KknsvFVoBJWFcXatG8XVnVy
         jWVx3gg9IjA4mm8COkmVVZi19bPGA4B6kleA2c/kS8O4PHn+/zY7w6A/rJk9fvX9NRZ/
         3d95tHKpUWZDV+ffmm0NnyOc8ZlNQtruTJKXYyt2pJwfzOFquFRhY7Q6wgkXzZgAsSRO
         eH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Vx/AV9moqrhgu7Ph+ldHwoba6eE+vsY0eVf5PphJ6Q=;
        b=Uc5yxiQoNPTi2ZdKehcDWqx5zKshU1n8Ui2OBbGD9TuGATjY2dP0WzVX2y5T7KwP2a
         mlu0c9pPjOOUuAynYimRAijeZq+F2aDGMYal2EtaheT8Dy/M9rpW50AZz8fz1b2LileB
         BJPRT00nY4ona/k+WdfauPFcDRNK4MGyqrAmcIEyrH9dtIGYVmKQABXL1NaiW0SrhtfZ
         wY9HS2XNnAoqybr2/Q03zSAGzXo5raAv2WXAVDdg1/g+HYnCclPHswf9XPrdtaUDeO0C
         F3hw/FG7CCSDo0Zfb2uBOu4BtfjyKw+xnRbEXs4JX5iWOWbCu4IydJ7ODkCH4namgxEB
         b+2g==
X-Gm-Message-State: APjAAAVYxryqIzTtApJ85LMDQHj4m5AyIAATrsoUoqa76eOrtwpu96md
        WRK9ZaWGF3HLKlXh1VvR+KQmQA==
X-Google-Smtp-Source: APXvYqzC9E1yp2G7Xyc1cwuJdKnyYxiQrsb5lhUKqgElieZfZJzFkChYrjRVO0RUtOQsIRIRs8KcZg==
X-Received: by 2002:a17:90a:b30a:: with SMTP id d10mr21505283pjr.8.1559761601785;
        Wed, 05 Jun 2019 12:06:41 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id r64sm29874790pfr.58.2019.06.05.12.06.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 12:06:41 -0700 (PDT)
Date:   Wed, 5 Jun 2019 12:06:40 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH] revert async probing of VMBus scsi device
Message-ID: <20190605120640.00358689@hermes.lan>
In-Reply-To: <20190605185637.GA31439@infradead.org>
References: <20190605185205.12583-1-sthemmin@microsoft.com>
        <20190605185637.GA31439@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, 5 Jun 2019 11:56:37 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Jun 05, 2019 at 11:52:05AM -0700, Stephen Hemminger wrote:
> > Doing asynchronous probing can lead to reordered device names
> > which is leads to failed mounts.  
> 
> Which is true for every device, and why we use UUIDs or label for
> mounts that are supposed to be stable.

Not everyone is smart enough to do that.
