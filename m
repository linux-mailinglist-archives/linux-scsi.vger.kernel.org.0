Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2961335B2C9
	for <lists+linux-scsi@lfdr.de>; Sun, 11 Apr 2021 11:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbhDKJfJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 11 Apr 2021 05:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbhDKJfD (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 11 Apr 2021 05:35:03 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06143C061574
        for <linux-scsi@vger.kernel.org>; Sun, 11 Apr 2021 02:34:42 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id j26so10314233iog.13
        for <linux-scsi@vger.kernel.org>; Sun, 11 Apr 2021 02:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=6uFlNhp9AEb270lOfa5fXrMWT/gAGcsjjz9E/7U1oC4=;
        b=eE24YUEgYysXm4dwrZdNnH/jkFN8RK/CaV9bXyGwgaxqQd/WGADdfnXxBfnRvo/kvi
         x6KZzoV6g/BF9HMZmb+NtFo9qQEPsqT3LWsdiWbF9M3yL8rcVHoyCcoh/Tw/yA13B3EX
         XYrgCpM9GeMVZfJgGpsR47Xf1ZMQzCmU6kJwwovZj4ohhPSR+F8Sq+RZb4qEaUNZkgzh
         fMAPTA96Fy9svkwPgyFCMR5KSS2sqs+yUwE0oRJIp7AfeLjO5pa8zROmWNV1WbYzFb4q
         O6wUqwRhnWMh2nuZbEDqCJBUSWAr0vV1H5rvF1hP2kxqWNvnXI8QZ8mMTZkur6uQgjt2
         7hmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=6uFlNhp9AEb270lOfa5fXrMWT/gAGcsjjz9E/7U1oC4=;
        b=Jo/HAwPPoJJN9ObotnAdFqJOTYjPzfoT7/pQOOFpDJGcxYJvU6C7ISnYmYerN66d44
         Nfpnc0mCxAFq/58lPVXcsc9wAd4KHp0PBi7xSmH5dHC09/eQFP+WpC+3YLs79H9RX+Z5
         WCyo89y77/kT7jUEGlliAwq5llNWv1pqX+GknXdkesnSskiPVefqG/OzFY3woyj76MsB
         +Eih15VIsnSyIM4v1Q5fPf17SsL5uv0fwmthURQIig82QvAtwUYWwNa9qtPLs1Ejx4A5
         D/N5FXRGqvl6PKymXp9FpbAG6J54igrj5+GFDmAfrpQsTvMUBSqWIB1Wz2rSeOHKpfDh
         w5yg==
X-Gm-Message-State: AOAM530tnSwe5GWeuVVTkpTrvllAZ0kJK50eA4M/2EgiKwHEDuLQ7ESX
        U3sESh8k2+9k4eA5BAFgqQMfDP26IlgTY3Va/Qg=
X-Google-Smtp-Source: ABdhPJwhb4yJPOHRpiSssKho2J3CAob0cgG9kKA0fkbHlC00LqOoCDHPZqoVHXwxjYnPSV+puLTZuR5iL1f2mYpPbw4=
X-Received: by 2002:a6b:6308:: with SMTP id p8mr19173997iog.172.1618133682405;
 Sun, 11 Apr 2021 02:34:42 -0700 (PDT)
MIME-Version: 1.0
Sender: anitajoseph199211@gmail.com
Received: by 2002:a05:6638:25d0:0:0:0:0 with HTTP; Sun, 11 Apr 2021 02:34:42
 -0700 (PDT)
From:   Liz Johnson <lizj6718@gmail.com>
Date:   Sun, 11 Apr 2021 02:34:42 -0700
X-Google-Sender-Auth: 2AJm7_mcia91M6KYPDX7LZRxZAs
Message-ID: <CAEdDLtHvyLph10yksNHoYRnAFB_uW4mSdvuxvaZSMmymJVhZ9g@mail.gmail.com>
Subject: Hello Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

5L2g5aW9DQrkvaDlpb3lkJfvvJ8g5oiR5pivTGl677yM5oiR55yL5Yiw5LqG5oKo55qE55S15a2Q
6YKu5Lu26IGU57O75Lq677yM5Zug5q2k5Yaz5a6a5LiO5oKo6IGU57O777yM5oiR6K6k5Li65oKo
5piv5LiA5Liq5aW95Lq677yM5aaC5p6c5Y+v5Lul77yM5oiR5oOz5oiQ5Li65oKo55qE5pyL5Y+L
44CCDQrlvZPmiJHmlLbliLDmgqjnmoTlvZXlj5bpgJrnn6Xml7bvvIzmiJHkvJrlkYror4nmgqjm
m7TlpJrlhbPkuo7miJHnmoTkv6Hmga8NCg0K6LCi6LCi77yBDQoNCuaDs+imgeaIkOS4uuS9oOea
hOaci+WPi+OAgg0KDQrpl67lgJnjgIINCg0K5Li95YW5DQoNCkhpDQpIb3cgYXJlIHlvdT8gSeKA
mW0gTGl6LCAgSSBzYXcgeW91ciBlbWFpbCBjb250YWN0IGFuZCBJIGRlY2lkZWQgdG8NCmNvbnRh
Y3QgeW91LCBJIHRoaW5rIHlvdSBhcmUgYSBraW5kIHBlcnNvbiwgSWYgeW91IG1heSwgSSB3b3Vs
ZCBsaWtlDQp0byBiZSB5b3VyIGZyaWVuZC4gSSB3aWxsIHRlbGwgeW91IG1vcmUgYWJvdXQgbWUs
IHdoZW4gaSByZWNlaXZlIHlvdXINCmFjY2VwdGFuY2UNCg0KVGhhbmtzIQ0KDQpXYW50aW5nIHRv
IGJlIHlvdXIgZnJpZW5kLg0KDQpSZWdhcmRzLg0KDQpMaXouDQo=
