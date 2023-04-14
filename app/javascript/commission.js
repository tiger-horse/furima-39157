function commission (){
  const priceInput  = document.getElementById("item-price");
  
  priceInput.addEventListener("keyup", () => {
    const countVal = priceInput.value;
    
    const addTaxDom  = document.getElementById("add-tax-price");
    addTaxDom.innerHTML = Math.round(countVal * 0.1);

    const profitNum  = document.getElementById("profit");
    profitNum.innerHTML = Math.round(priceInput.value - addTaxDom.innerHTML);
  });
};

window.addEventListener('load', commission);
