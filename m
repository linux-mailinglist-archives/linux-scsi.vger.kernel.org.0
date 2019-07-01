Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED22D2E723
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 23:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfE2VNV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 17:13:21 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46193 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfE2VNV (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 17:13:21 -0400
Received: by mail-pl1-f194.google.com with SMTP id bb3so1568854plb.13
        for <linux-scsi@vger.kernel.org>; Wed, 29 May 2019 14:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=osu/x7FYody2Hoq4uLkPS7Kf2axeOtjhm45H0GWnEgQ=;
        b=Q6iFvgkjVosWfknWr+UHUu0tmky9zm33+DXECZJslVHVhgXMsWHIDiQZUWXntUatCA
         gtYtKge8bQKNw1zPDJ0JxtkDBeLOpk3n788p8jLzboez7cOBdOk3xMXVZZPGpxyS3x9K
         +Uae5F7tOGpwhfcoxXyxW9GrTiMJP+LtO4R7t7p84TuVCE5nj5cKaDb3THXzC3kIsMSO
         io4gJPe2eByMBwXK8RaTcVVnnCWsrJWs+ZmBy1Y71cXlPSbo70tjOnP6CFlK+yP2SeY8
         Uzz2631SlXTf5bRFwZcUyeYsXMkgfBtrNwaHVgCJ3IUlahWRyBWs6lNAckn6GmoeAOfu
         R2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=osu/x7FYody2Hoq4uLkPS7Kf2axeOtjhm45H0GWnEgQ=;
        b=sE3cAhfQHOlAAhGJ/RVhWctXsvEPPoDXYCtwWoX8ymEvNHtZGOjoX2tQROB84ICK6w
         F8DqbRriAQfq6YeCBDJpbLZp0wFaNcyOt2VmqiCJitQExJESzbXZDC+MuaHTRv6Idl2j
         HH9hPqIdIZXLOET6p291ZSwtd4jr8IdW86vyKlWWtbpxcyuJ5+XZjEmzRaHpLxLHHOlA
         qe7IByqCd1fEhpn22QLUbgLKUBuTMqOnmUlOs/chXAznQJwq/TcD9FlyXxp+N8VhrEc4
         jAtAV+ZKFYaB5f8TG9HBsUPsE9VkR0Mb5fTxkVF6B+n3z8SXwSBpmcRdIfU3iDTfEMOA
         7KYQ==
X-Gm-Message-State: APjAAAUZyMk6cPLqTB9yQ96p4MtXNxmELcgE0AmTv/qLpjOaIG+vwzn5
        zEzK172KDmuBAe6ixKWilGvNRQ==
X-Google-Smtp-Source: APXvYqzftdCMQALgk0F9juagotZqZQeBmfKRPjM6r0YhL7Q3xcrGdfu8ua/UIAWP7PZs3j5qSvlnbg==
X-Received: by 2002:a17:902:a508:: with SMTP id s8mr123754339plq.186.1559164400332;
        Wed, 29 May 2019 14:13:20 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 80sm584101pfv.38.2019.05.29.14.13.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 14:13:19 -0700 (PDT)
Date:   Wed, 29 May 2019 14:13:18 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Ondrej Zary <linux@rainbow-software.org>
cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v2] wd719x: pass GFP_ATOMIC instead of GFP_KERNEL
In-Reply-To: <20190529175851.GA10760@hari-Inspiron-1545>
Message-ID: <alpine.DEB.2.21.1905291412360.242480@chino.kir.corp.google.com>
References: <20190529175851.GA10760@hari-Inspiron-1545>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, 29 May 2019, Hariprasad Kelam wrote:

> dont acquire lock before calling wd719x_chip_init.
> 
> Issue identified by coccicheck
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> -----
> changes in v1: Replace GFP_KERNEL with GFP_ATOMIC.
> changes in v2: Call wd719x_chip_init  without lock as suggested
> 		in review

Why was host_lock taken here initially?  I assume it's to protect some 
race in init that leads to an undefined state.
