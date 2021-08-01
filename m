Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909863DC96E
	for <lists+linux-scsi@lfdr.de>; Sun,  1 Aug 2021 05:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhHADaw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 31 Jul 2021 23:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhHADav (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 31 Jul 2021 23:30:51 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950B0C06175F
        for <linux-scsi@vger.kernel.org>; Sat, 31 Jul 2021 20:30:43 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id l19so20872499pjz.0
        for <linux-scsi@vger.kernel.org>; Sat, 31 Jul 2021 20:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=f9edfBUeVsTh74HmqsxezUMifARYRRH8It18mZO5R+w=;
        b=CaBwmpbFwB8rdNl56HY68y0LPkeJGJjjXqcDZMn7rewvB0ZtnsF2pyycWMsyzU7udU
         1Rb+DWK30InQzWNhMKV1claBViLUUJlBxu5Q9F673qmHrvAqmQKBzcTryBx+LVOobiL4
         Jjj/BsYmhUb0dsFpGbMdTO6SXcE9lRbgZEhAjhoXookQlRzZUtE38T+OPPBUErlmDTTP
         SzCXC4F2jXAeoABjQlQsY4d5qoIDQOmfbFLpcIQxT+gzlrW4motyPtsU14IhZD7PPnRP
         bzYBiYjuqSATtItJoqCfv+I+AJKj7GGx1T7Fa2wSe1aMZ6qtPEZIkSZJchyMcfudoRPL
         +UvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=f9edfBUeVsTh74HmqsxezUMifARYRRH8It18mZO5R+w=;
        b=afrDPcvEjBrdcFESQNMdw8dKyy6D2/3fYqX1loXxs5uUIVdTrbG3ecATFqAL0OE3W9
         kwk+3rJy+o9RLBQbZdWxKWBOQCv73rwBdSSYPoI8tNZiS6XlEuiN+lZJghiO1ch6VbYj
         PnaeWls6xgrqh8a1NefVtASi7BZSRyfUXGNTAcKT1FjIHWu53WZvv5tAaNvUqEoGBMdU
         3hfXlZzGMFY9n9x/FNJhlSidLqZ9H5wqoWZZzDbY6LXtR3JA3gvuUonSGZbV/R93EGrL
         Y0p45X0ConopZ5FbqJwMK9jgDuTs5HlIWYh/E925LwvNViShUkPOTSB1QpZGlxaRQleq
         WeWA==
X-Gm-Message-State: AOAM533z2pw+HjyBerLYKfUItQ9DdJfYwA87oP8QqNIfmGAaOAey23kA
        y6XWuKrGK8ctKAeD8CtG6VxJlIcG0AoJUBOF2kqjm5dG2fo=
X-Google-Smtp-Source: ABdhPJx5l6/flQRVpyEZGpcrjTQGA1O70EONzVOKr5fFLaCwT9oa7tUd9uvpWE6iPtJn6uCzRFKO/5CwRNBS4FiA9tk=
X-Received: by 2002:a63:ff51:: with SMTP id s17mr1275714pgk.415.1627788642223;
 Sat, 31 Jul 2021 20:30:42 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?5Lq/5LiA?= <teroincn@gmail.com>
Date:   Sun, 1 Aug 2021 11:30:32 +0800
Message-ID: <CANTwqXDL8+utcMG15b1DWEFderrb92+Zbdvt4Z1zOd5YoH32mQ@mail.gmail.com>
Subject: [BUG]scsi: bnx2fc: bnx2fc_els.c: two refcount leak in function
 bnx2fc_initiate_seq_cleanup and bnx2fc_eh_abort
To:     skashyap@marvell.com, jhasan@marvell.com,
        GR-QLogic-Storage-Upstream@marvell.com
Cc:     linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi,

I found there are two possible refcount leak in the bnx2fc driver in v5.14-rc3:

In bnx2fc_initiate_seq_cleanup :
946: kref_get(&orig_io_req->refcount);

this refcnt increment won't be released in:
994: cleanup_err:
995: return rc;


similar issue happens in bnx2fc_eh_abort:
1161: kref_get(&io_req->refcount);
1187: return FAILED;

Is it a refcount leak or just a valid refcount increment?
Any feedback would be appreciated, thanks~ :)


Best wishes,
Lin Yi
